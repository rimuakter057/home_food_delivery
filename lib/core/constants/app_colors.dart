import 'package:flutter/material.dart';

/// Design tokens extracted directly from the Figma file
/// (4RTwFj2j4rr4e8p2xoYPUb, "Happypphoto || Food Delivery App").
/// No Figma Variables are bound in the source file, so these are the
/// literal fills used across screens/components — treat this file as
/// the single source of truth and never hardcode a hex value elsewhere.
class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF2E7D32);
  static const Color primaryDark = Color(0xFF2E7E32);
  static const Color background = Color(0xFFEAFBFF);
  static const Color surface = Color(0xFFFFFFFF);

  static const Color textPrimary = Color(0xFF212121);
  static const Color textLabel = Color(0xFF424242);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textMuted = Color(0xFF9E9E9E);
  static const Color textPlaceholder = Color(0xFFBABABA);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  static const Color border = Color(0xFF6B7280);
  static const Color divider = Color(0xFFE0E0E0);
  static const Color link = Color(0xFF1565C0);

  /// Subtitle color on the onboarding gradient — rgba(74,148,77,0.8).
  static const Color onboardingSubtitle = Color(0xCC4A944D);

  static const Color error = Color(0xFFD32F2F);
  static const Color success = primary;
  static const Color warning = Color(0xFFF5A623);
  static const Color ratingStar = Color(0xFFF57C00);

  static const Color cardShadow = Color(0x14000000); // rgba(0,0,0,0.08)
  static const Color navBarBorder = Color(0x7A2E7D32); // rgba(46,125,50,0.48)
  static const Color navBarShadow = Color(0x3D167EE6); // rgba(22,126,230,0.24)

  // Checkout — Property Code tab (host/rental delivery flow)
  static const Color tealSurface = Color(0xFFE0F2F1);
  static const Color tealText = Color(0xFF00695C);
  static const Color infoBadgeBackground = Color(0xFFE3F2FD);
  static const Color linkBadgeBackground = Color(0x1F1565C0); // rgba(21,101,192,0.12)
  static const Color stepDoneBackground = Color(0xFFE8F5E9);

  /// Onboarding hero background, 155.5deg linear gradient.
  static const List<Color> onboardingGradient = [
    Color(0xFFF1F5F6),
    Color(0xFFD9FED8),
    Color(0xFFBCF8BF),
    Color(0xFFA7FFAB),
    Color(0xFF53E45A),
  ];

  // Promo banner gradients (home_mock_data.dart PromoBannerModel entries).
  static const List<Color> gradientOrange = [Color(0xFF7FD88A), Color(0xFF2E7D32)];
  static const List<Color> gradientTeal = [Color(0xFF6EE7DE), Color(0xFF1565C0)];
  static const List<Color> gradientPurple = [Color(0xFFA78BFA), Color(0xFF7C3AED)];
}
