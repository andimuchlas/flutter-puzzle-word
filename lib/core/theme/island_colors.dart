import 'package:flutter/material.dart';

/// Design tokens from Stitch "Island Sanctuary" theme
/// Primary brand: Cerulean Ocean (#006194 / #0284c7)
/// Secondary brand: Amber Sunshine (#fea619 / #f59e0b)
/// Tertiary brand: Island Emerald (#16a34a / #006947)
/// Base surface: Calm Shore (#faf8ff / #f8fafc)
class IslandColors {
  // Primary (Ocean / Brand)
  static const Color primary = Color(0xFF006194);
  static const Color primaryDark = Color(0xFF004B73);
  static const Color primaryLight = Color(0xFF0284C7);
  static const Color primaryContainer = Color(0xFF007BB9);
  static const Color primaryFixed = Color(0xFFCCE5FF);
  static const Color primaryFixedDim = Color(0xFF93CCFF);
  static const Color onPrimary = Colors.white;

  // Secondary (Gold / Coin / Star / Playful Accent)
  static const Color secondary = Color(0xFF855300);
  static const Color secondaryContainer = Color(0xFFFEA619);
  static const Color secondaryDark = Color(0xFFB45309);
  static const Color secondaryFixed = Color(0xFFFFDDB8);
  static const Color secondaryFixedDim = Color(0xFFFFB95F);
  static const Color onSecondary = Colors.white;
  static const Color onSecondaryContainer = Color(0xFF2A1700);

  // Tertiary / Success (Emerald / Solved Word / Play CTA)
  static const Color tertiary = Color(0xFF006947);
  static const Color tertiaryContainer = Color(0xFF00855B);
  static const Color gameGreen = Color(0xFF16A34A);
  static const Color gameGreenDark = Color(0xFF15803D);
  static const Color gameGreenShadow = Color(0xFF0F612D);
  static const Color gameGreenLight = Color(0xFF4ADE80);
  static const Color onTertiary = Colors.white;
  static const Color tertiaryFixed = Color(0xFF6FFBBE);

  // Surfaces & Backgrounds
  static const Color surface = Color(0xFFF8FAFC);
  static const Color surfaceDim = Color(0xFFD2D9F4);
  static const Color surfaceBright = Color(0xFFFAF8FF);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFF2F3FF);
  static const Color surfaceContainer = Color(0xFFEAEDFF);
  static const Color surfaceContainerHigh = Color(0xFFE2E7FF);
  static const Color surfaceContainerHighest = Color(0xFFDAE2FD);

  // Borders, Dividers & Outlines
  static const Color outline = Color(0xFF707881);
  static const Color outlineVariant = Color(0xFFBFC7D2);
  static const Color outlineLight = Color(0xFFE2E8F0);

  // Typography & Text
  static const Color onSurface = Color(0xFF0F172A);
  static const Color onSurfaceVariant = Color(0xFF475569);
  static const Color textMuted = Color(0xFF64748B);

  // Crossword Cell specifics
  static const Color cellEmpty = Colors.white;
  static const Color cellEmptyBorder = Color(0xFFCBD5E1);
  static const Color cellActiveWord = Color(0xFFE0F2FE);
  static const Color cellActiveWordBorder = Color(0xFF38BDF8);
  static const Color cellBlocked = Color(0xFFCBD5E1);
  static const Color cellSolved = Color(0xFFE0F7EF);
  static const Color cellSolvedText = Color(0xFF006947);

  // Letter Wheel / Ribbon
  static const Color wheelDiscBase = Color(0xFFF8FAFC);
  static const Color wheelRibbon = Color(0xFF0284C7);
  static const Color wheelRibbonGlow = Color(0xFF38BDF8);
  static const Color wheelLetterActive = Color(0xFF0284C7);
  static const Color wheelLetterActiveBg = Color(0xFFE0F2FE);

  // Alert & Error
  static const Color error = Color(0xFFBA1A1A);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onError = Colors.white;
}
