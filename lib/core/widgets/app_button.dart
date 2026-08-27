import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../utils/responsive_helper.dart';

/// The three button fills used across the Figma file:
/// - [primary]: solid `AppColors.primary`, white text — the default CTA.
/// - [outline]: 2px primary border, primary text, transparent fill — used
///   e.g. for the "Sign In" tab next to a selected "Sign Up" tab.
/// - [translucent]: white-at-15%-opacity fill with a white-at-40% border,
///   white text — used for secondary actions on top of the green hero
///   background (e.g. "Become a Property Host").
enum AppButtonVariant { primary, outline, translucent }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
    this.variant,
    this.icon,
    this.large = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  /// Kept for backward compatibility — equivalent to `variant: AppButtonVariant.outline`.
  final bool isOutlined;
  final AppButtonVariant? variant;
  final IconData? icon;

  /// Uses the larger 16px label (Figma's "Next" button) instead of the
  /// default 14px CTA label.
  final bool large;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final resolvedVariant = variant ?? (isOutlined ? AppButtonVariant.outline : AppButtonVariant.primary);
    final textStyle = large ? AppTextStyles.buttonLabelLarge : AppTextStyles.buttonLabel;

    final Color foregroundColor;
    switch (resolvedVariant) {
      case AppButtonVariant.primary:
        foregroundColor = AppColors.textOnPrimary;
        break;
      case AppButtonVariant.outline:
        foregroundColor = AppColors.primary;
        break;
      case AppButtonVariant.translucent:
        foregroundColor = AppColors.textOnPrimary;
        break;
    }

    final child = isLoading
        ? SizedBox(
            height: responsive.iconSize(20),
            width: responsive.iconSize(20),
            child: CircularProgressIndicator(strokeWidth: 2, color: foregroundColor),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: responsive.iconSize(18), color: foregroundColor),
                SizedBox(width: responsive.spacing(8)),
              ],
              Text(label, style: textStyle.copyWith(color: foregroundColor)),
            ],
          );

    final borderRadius = BorderRadius.circular(responsive.radius(8));

    Widget button;
    switch (resolvedVariant) {
      case AppButtonVariant.primary:
        button = ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: borderRadius)),
          child: child,
        );
        break;
      case AppButtonVariant.outline:
        button = OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: borderRadius)),
          child: child,
        );
        break;
      case AppButtonVariant.translucent:
        button = OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.white.withValues(alpha: 0.15),
            side: BorderSide(color: Colors.white.withValues(alpha: 0.4)),
            shape: RoundedRectangleBorder(borderRadius: borderRadius),
          ),
          child: child,
        );
        break;
    }

    return SizedBox(width: double.infinity, height: responsive.size(48), child: button);
  }
}
