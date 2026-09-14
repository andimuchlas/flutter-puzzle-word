import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'island_colors.dart';

/// Typography definitions based on Stitch Design System
/// - Headlines / Tiles: Rubik
/// - Body / Labels: Plus Jakarta Sans
class IslandTypography {
  // Rubik Headlines & Titles
  static TextStyle displayLg({Color color = IslandColors.onSurface}) =>
      GoogleFonts.rubik(
        fontSize: 36,
        fontWeight: FontWeight.w800,
        height: 1.2,
        color: color,
      );

  static TextStyle headlineLg({Color color = IslandColors.onSurface}) =>
      GoogleFonts.rubik(
        fontSize: 26,
        fontWeight: FontWeight.w700,
        height: 1.25,
        color: color,
      );

  static TextStyle headlineMd({Color color = IslandColors.onSurface}) =>
      GoogleFonts.rubik(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        height: 1.3,
        color: color,
      );

  static TextStyle headlineSm({Color color = IslandColors.onSurface}) =>
      GoogleFonts.rubik(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 1.3,
        color: color,
      );

  static TextStyle titleTile({Color color = IslandColors.onSurface}) =>
      GoogleFonts.rubik(
        fontSize: 22,
        fontWeight: FontWeight.w800,
        height: 1.0,
        color: color,
      );

  // Plus Jakarta Sans Body & Labels
  static TextStyle bodyLg({Color color = IslandColors.onSurface}) =>
      GoogleFonts.plusJakartaSans(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        height: 1.4,
        color: color,
      );

  static TextStyle bodyMd({Color color = IslandColors.onSurface}) =>
      GoogleFonts.plusJakartaSans(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        height: 1.35,
        color: color,
      );

  static TextStyle bodySm({Color color = IslandColors.onSurfaceVariant}) =>
      GoogleFonts.plusJakartaSans(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        height: 1.3,
        color: color,
      );

  static TextStyle labelLg({Color color = IslandColors.onSurface}) =>
      GoogleFonts.plusJakartaSans(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.4,
        height: 1.2,
        color: color,
      );

  static TextStyle labelMd({Color color = IslandColors.onSurface}) =>
      GoogleFonts.plusJakartaSans(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.3,
        height: 1.2,
        color: color,
      );

  static TextStyle labelSm({Color color = IslandColors.onSurfaceVariant}) =>
      GoogleFonts.plusJakartaSans(
        fontSize: 9.5,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.4,
        height: 1.2,
        color: color,
      );
}
