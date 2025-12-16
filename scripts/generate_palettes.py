#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.11"
# dependencies = []
# ///
"""
Generate SVG palette visualizations and PALETTE.md with contrast metrics.

Usage:
    ./scripts/generate_palettes.py
    # or
    uv run --script scripts/generate_palettes.py
"""

from __future__ import annotations

import re
from pathlib import Path
from typing import NamedTuple

# Project root (parent of scripts/)
PROJECT_ROOT = Path(__file__).parent.parent
COLORS_DIR = PROJECT_ROOT / "lua" / "monoglow" / "colors"
OUTPUT_DIR = PROJECT_ROOT / "assets"  # Output SVGs to assets/
PALETTE_MD = PROJECT_ROOT / "PALETTE.md"

# SVG dimensions - target ~700px width for GitHub README
SWATCH_WIDTH = 72
SWATCH_HEIGHT = 40  # More rectangular (ratio ~1.8:1)
SWATCH_SPACING = 4  # Uniform spacing between columns
ROW_SPACING = 4  # Uniform spacing between rows
BORDER_RADIUS = 4  # Subtle rounding
PADDING = 16

# Shared colors (git + diagnostics) - these don't change between themes
# Hardcoded from z.lua as the canonical source
SHARED_COLORS = [
    ("add", "#baffc9"),
    ("change", "#ffffba"),
    ("delete", "#ffb3ba"),
    ("red", "#ffc0b9"),
    ("yellow", "#fce094"),
    ("green", "#b3f6c0"),
    ("cyan", "#8cf8f7"),
    ("blue", "#a6dbff"),
    ("magenta", "#ffcaff"),
]

# Background color for shared palette (z's bg)
SHARED_BG = "#121212"


class Color(NamedTuple):
    """A named color with its hex value."""

    name: str
    hex: str


def hex_to_rgb(hex_color: str) -> tuple[float, float, float]:
    """Convert hex color to RGB tuple (0-1 range)."""
    hex_color = hex_color.lstrip("#")
    r = int(hex_color[0:2], 16) / 255.0
    g = int(hex_color[2:4], 16) / 255.0
    b = int(hex_color[4:6], 16) / 255.0
    return (r, g, b)


def relative_luminance(rgb: tuple[float, float, float]) -> float:
    """Calculate relative luminance per WCAG 2.1."""

    def adjust(c: float) -> float:
        return c / 12.92 if c <= 0.03928 else ((c + 0.055) / 1.055) ** 2.4

    r, g, b = rgb
    return 0.2126 * adjust(r) + 0.7152 * adjust(g) + 0.0722 * adjust(b)


def contrast_ratio(color1: str, color2: str) -> float:
    """Calculate WCAG contrast ratio between two hex colors."""
    l1 = relative_luminance(hex_to_rgb(color1))
    l2 = relative_luminance(hex_to_rgb(color2))
    lighter = max(l1, l2)
    darker = min(l1, l2)
    return (lighter + 0.05) / (darker + 0.05)


def text_color_for_background(bg_hex: str) -> str:
    """Return white or black depending on background luminance."""
    lum = relative_luminance(hex_to_rgb(bg_hex))
    return "#ffffff" if lum < 0.5 else "#000000"


def parse_lua_palette(filepath: Path) -> dict[str, str]:
    """Extract color definitions from a Lua palette file."""
    content = filepath.read_text()
    colors: dict[str, str] = {}

    # Match simple assignments: key = "#hexcode"
    simple_pattern = re.compile(r'(\w+)\s*=\s*"(#[0-9a-fA-F]{6})"')
    for match in simple_pattern.finditer(content):
        colors[match.group(1)] = match.group(2).lower()

    # Match nested table assignments: key = { subkey = "#hexcode" }
    # e.g., git = { add = "#baffc9", ... }
    # Use a more specific pattern that finds inner tables (not the outer ret = {})
    # Look for "word = {" followed by content with hex colors inside
    nested_pattern = re.compile(
        r"(\w+)\s*=\s*\{\s*\n?\s*(\w+)\s*=\s*\"(#[0-9a-fA-F]{6})\"", re.MULTILINE
    )

    for match in nested_pattern.finditer(content):
        table_name = match.group(1)
        # Skip the outer 'ret' or 'local' table wrapper
        if table_name in ("ret", "local"):
            continue
        # Found a real nested table, extract all its color values
        # Find the position and extract the full table content
        start = match.start()
        # Find matching closing brace
        brace_count = 0
        table_start = content.find("{", start)
        table_end = table_start
        for i, char in enumerate(content[table_start:], table_start):
            if char == "{":
                brace_count += 1
            elif char == "}":
                brace_count -= 1
                if brace_count == 0:
                    table_end = i
                    break
        inner = content[table_start + 1 : table_end]
        for inner_match in simple_pattern.finditer(inner):
            key = f"{table_name}.{inner_match.group(1)}"
            colors[key] = inner_match.group(2).lower()

    return colors


def get_style_colors(style: str) -> dict[str, str]:
    """Get colors for a style, handling inheritance from z.lua."""
    # Always start with base z palette
    base_path = COLORS_DIR / "z.lua"
    colors = parse_lua_palette(base_path)

    # If not z, overlay style-specific colors
    if style != "z":
        style_path = COLORS_DIR / f"{style}.lua"
        if style_path.exists():
            style_colors = parse_lua_palette(style_path)
            colors.update(style_colors)

    return colors


def get_main_color_rows(colors: dict[str, str]) -> list[list[Color]]:
    """Organize main colors into display rows (2 rows of 9)."""
    rows: list[list[Color]] = []

    # Row 1: Background + dark/mid grays (9 colors)
    row1_names = [
        "bg",
        "gray1",
        "gray2",
        "gray3",
        "gray4",
        "gray5",
        "gray6",
        "gray7",
        "gray8",
    ]
    row1 = [Color(name, colors[name]) for name in row1_names if name in colors]
    rows.append(row1)

    # Row 2: Light grays + accents (9 colors)
    row2_names = [
        "gray9",
        "gray10",
        "fg",
        "white",
        "glow",
        "lack",
        "luster",
        "blue1",
        "blue2",
    ]
    row2 = [Color(name, colors[name]) for name in row2_names if name in colors]
    rows.append(row2)

    return rows


def get_shared_color_row() -> list[Color]:
    """Get the shared colors row (git + diagnostics)."""
    return [Color(name, hex_val) for name, hex_val in SHARED_COLORS]


def generate_svg_for_rows(rows: list[list[Color]], bg_color: str) -> str:
    """Generate SVG palette visualization for given rows."""
    # Calculate dimensions
    num_cols = 9
    width = PADDING * 2 + num_cols * SWATCH_WIDTH + (num_cols - 1) * SWATCH_SPACING
    height = PADDING * 2 + len(rows) * SWATCH_HEIGHT + (len(rows) - 1) * ROW_SPACING

    # Build SVG (no title)
    svg_parts = [
        f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {width} {height}" width="{width}" height="{height}">',
        f'  <rect width="{width}" height="{height}" fill="{bg_color}"/>',
    ]

    y_offset = PADDING

    for row in rows:
        x_offset = PADDING
        for color in row:
            text_color = text_color_for_background(color.hex)
            # Swatch rectangle with subtle border radius
            svg_parts.append(
                f'  <rect x="{x_offset}" y="{y_offset}" width="{SWATCH_WIDTH}" '
                f'height="{SWATCH_HEIGHT}" rx="{BORDER_RADIUS}" fill="{color.hex}"/>'
            )
            # Color name (inside swatch, top)
            svg_parts.append(
                f'  <text x="{x_offset + SWATCH_WIDTH // 2}" y="{y_offset + 15}" '
                f'font-family="ui-monospace, monospace" font-size="9" fill="{text_color}" '
                f'text-anchor="middle">{color.name}</text>'
            )
            # Hex code (inside swatch, bottom)
            svg_parts.append(
                f'  <text x="{x_offset + SWATCH_WIDTH // 2}" y="{y_offset + 29}" '
                f'font-family="ui-monospace, monospace" font-size="9" fill="{text_color}" '
                f'text-anchor="middle">{color.hex}</text>'
            )
            x_offset += SWATCH_WIDTH + SWATCH_SPACING

        y_offset += SWATCH_HEIGHT + ROW_SPACING

    svg_parts.append("</svg>")
    return "\n".join(svg_parts)


def generate_main_svg(style: str, colors: dict[str, str]) -> str:
    """Generate SVG palette visualization for main colors (2 rows)."""
    rows = get_main_color_rows(colors)
    bg_color = colors.get("bg", "#121212")
    return generate_svg_for_rows(rows, bg_color)


def generate_shared_svg() -> str:
    """Generate SVG palette visualization for shared colors (1 row)."""
    rows = [get_shared_color_row()]
    return generate_svg_for_rows(rows, SHARED_BG)


def generate_contrast_table(style: str, colors: dict[str, str]) -> str:
    """Generate markdown contrast table for a style."""
    bg = colors.get("bg", "#121212")

    # Colors to measure against background (main colors only)
    measure_colors = [
        ("fg", "Main text"),
        ("gray8", "Variables, functions"),
        ("gray7", "Strings, types"),
        ("gray6", "Keywords"),
        ("gray5", "Secondary text"),
        ("gray4", "Line numbers, gutter"),
        ("glow", "Accent / search"),
        ("lack", "Tribute accent"),
        ("luster", "Bright accent"),
        ("blue1", "Blue accent 1"),
        ("blue2", "Blue accent 2"),
    ]

    lines = [
        "| Color | Hex | Ratio | AA | AAA | Usage |",
        "|-------|-----|------:|:--:|:---:|-------|",
    ]

    for color_name, usage in measure_colors:
        if color_name not in colors:
            continue
        hex_val = colors[color_name]
        ratio = contrast_ratio(hex_val, bg)
        aa = "+" if ratio >= 4.5 else "-"
        aaa = "+" if ratio >= 7.0 else "-"
        lines.append(
            f"| {color_name} | `{hex_val}` | {ratio:.2f}:1 | {aa} | {aaa} | {usage} |"
        )

    return "\n".join(lines)


def generate_shared_contrast_table() -> str:
    """Generate markdown contrast table for shared colors against z's background."""
    lines = [
        "| Color | Hex | Ratio | AA | AAA | Usage |",
        "|-------|-----|------:|:--:|:---:|-------|",
    ]

    usages = {
        "add": "Git add",
        "change": "Git change",
        "delete": "Git delete",
        "red": "Error",
        "yellow": "Warning",
        "green": "Success / Ok",
        "cyan": "Info",
        "blue": "Hint",
        "magenta": "Special",
    }

    for name, hex_val in SHARED_COLORS:
        ratio = contrast_ratio(hex_val, SHARED_BG)
        aa = "+" if ratio >= 4.5 else "-"
        aaa = "+" if ratio >= 7.0 else "-"
        usage = usages.get(name, "")
        lines.append(
            f"| {name} | `{hex_val}` | {ratio:.2f}:1 | {aa} | {aaa} | {usage} |"
        )

    return "\n".join(lines)


def generate_palette_md(
    styles: list[str], all_colors: dict[str, dict[str, str]]
) -> str:
    """Generate PALETTE.md content."""
    lines = [
        "# Color Palettes",
        "",
        "Palette visualizations and WCAG contrast metrics for all Monoglow styles.",
        "",
        "> **WCAG 2.1**: AA requires 4.5:1 for normal text, AAA requires 7:1.",
        "> Contrast ratios are calculated against each style's background color.",
        "",
    ]

    for style in styles:
        colors = all_colors[style]
        bg = colors.get("bg", "#121212")
        style_title = style.capitalize() if style != "z" else "Z (default)"

        lines.extend(
            [
                f"## Monoglow {style_title}",
                "",
                f"![Monoglow {style_title} Palette](assets/palette-{style}.svg)",
                "",
                f"### Contrast Ratios (against `{bg}`)",
                "",
                generate_contrast_table(style, colors),
                "",
                "---",
                "",
            ]
        )

    # Shared colors section
    lines.extend(
        [
            "## Shared Colors (Git & Diagnostics)",
            "",
            "These colors are consistent across all Monoglow styles.",
            "",
            "![Shared Colors Palette](assets/palette-shared.svg)",
            "",
            f"### Contrast Ratios (against `{SHARED_BG}`)",
            "",
            generate_shared_contrast_table(),
            "",
        ]
    )

    return "\n".join(lines) + "\n"


def main() -> None:
    """Generate palette SVGs and PALETTE.md."""
    styles = ["z", "lack", "void"]

    # Ensure output directory exists
    OUTPUT_DIR.mkdir(exist_ok=True)

    # Collect all colors
    all_colors: dict[str, dict[str, str]] = {}

    for style in styles:
        print(f"[palettes] Processing {style}...")
        colors = get_style_colors(style)
        all_colors[style] = colors

        # Generate and write main SVG (2 rows)
        svg_content = generate_main_svg(style, colors)
        svg_path = OUTPUT_DIR / f"palette-{style}.svg"
        svg_path.write_text(svg_content)
        print(f"[palettes] Written {svg_path.relative_to(PROJECT_ROOT)}")

    # Generate and write shared SVG (1 row)
    print("[palettes] Processing shared colors...")
    shared_svg = generate_shared_svg()
    shared_path = OUTPUT_DIR / "palette-shared.svg"
    shared_path.write_text(shared_svg)
    print(f"[palettes] Written {shared_path.relative_to(PROJECT_ROOT)}")

    # Generate and write PALETTE.md
    md_content = generate_palette_md(styles, all_colors)
    PALETTE_MD.write_text(md_content)
    print(f"[palettes] Written {PALETTE_MD.relative_to(PROJECT_ROOT)}")

    print("[palettes] Done!")


if __name__ == "__main__":
    main()
