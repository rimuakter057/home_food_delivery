import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

/// Text styles matching the Figma type scale. Figma uses two families:
/// Poppins for headlines, screen titles, form labels and button text;
/// Inter for body copy, nav labels and card meta text.
/// Always reference these instead of building ad-hoc [TextStyle]s.
class AppTextStyles {
  AppTextStyles._();

  // Onboarding / hero headlines — Poppins SemiBold 32/36.
  static TextStyle get headlineLarge => GoogleFonts.poppins(
        fontSize: 32,
        height: 36 / 32,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  // Auth screen titles ("Create account", "Welcome back!") — Poppins Bold 24/32.
  static TextStyle get headlineMedium => GoogleFonts.poppins(
        fontSize: 24,
        height: 32 / 24,
        fontWeight: FontWeight.bold,
        color: AppColors.textOnPrimary,
      );

  // App bar / section titles ("Browse Stores") — Poppins SemiBold 16/28.
  static TextStyle get titleLarge => GoogleFonts.poppins(
        fontSize: 16,
        height: 28 / 16,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  // Form field labels ("Full Name", "Password") — Poppins Medium 16/16.
  static TextStyle get fieldLabel => GoogleFonts.poppins(
        fontSize: 16,
        height: 1,
        fontWeight: FontWeight.w500,
        color: AppColors.textLabel,
      );

  // Card titles ("Fresh Farms Co.") — Inter SemiBold 14/20.
  static TextStyle get titleSmall => GoogleFonts.inter(
        fontSize: 14,
        height: 20 / 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  // Button labels — Poppins SemiBold 14, loose leading (1.65) as in Figma.
  static TextStyle get buttonLabel => GoogleFonts.poppins(
        fontSize: 14,
        height: 1.65,
        fontWeight: FontWeight.w600,
        color: AppColors.textOnPrimary,
      );

  // Larger CTA labels ("Next") — Poppins SemiBold 16/24.
  static TextStyle get buttonLabelLarge => GoogleFonts.poppins(
        fontSize: 16,
        height: 24 / 16,
        fontWeight: FontWeight.w600,
        color: AppColors.textOnPrimary,
      );

  // Input text / placeholders — Inter Regular 14/20.
  static TextStyle get bodyMedium => GoogleFonts.inter(
        fontSize: 14,
        height: 20 / 14,
        fontWeight: FontWeight.normal,
        color: AppColors.textPrimary,
      );

  static TextStyle get placeholder => bodyMedium.copyWith(color: AppColors.textPlaceholder);

  // Secondary meta text (nav inactive labels, small captions) — Inter Regular 12/16.
  static TextStyle get bodySmall => GoogleFonts.inter(
        fontSize: 12,
        height: 16 / 12,
        fontWeight: FontWeight.normal,
        color: AppColors.textSecondary,
      );

  // Emphasized small text (nav active label, "4.9" rating, "Free") — Inter SemiBold/Medium 12/16.
  static TextStyle get labelSmall => GoogleFonts.inter(
        fontSize: 12,
        height: 16 / 12,
        fontWeight: FontWeight.w600,
        color: AppColors.primary,
      );

  // Muted footnote text (terms & privacy copy) — Inter Regular 12/16.
  static TextStyle get caption => GoogleFonts.inter(
        fontSize: 12,
        height: 16 / 12,
        fontWeight: FontWeight.normal,
        color: AppColors.textMuted,
      );

  // Dashboard stat counters ("04", "12") — Inter Bold 20/28.
  static TextStyle get numberLarge => GoogleFonts.inter(
        fontSize: 20,
        height: 28 / 20,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      );

  // Auth hero subtitles ("Sign in to continue shopping") — Poppins Regular 16/21, white.
  static TextStyle get heroSubtitle => GoogleFonts.poppins(
        fontSize: 16,
        height: 21 / 16,
        fontWeight: FontWeight.normal,
        color: Colors.white,
      );

  // Generated share/property codes ("PHX5784") — Inter Regular 32/40.
  static TextStyle get codeLarge => GoogleFonts.inter(
        fontSize: 32,
        height: 40 / 32,
        fontWeight: FontWeight.normal,
        color: AppColors.textPrimary,
      );
}
