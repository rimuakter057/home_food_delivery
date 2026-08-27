import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../utils/responsive_helper.dart';

/// The rounded-pill filter selector from the Browse Stores screen
/// (node 493:4907): white/unselected vs primary-green/selected, fully
/// rounded, Inter Medium 12px label.
class AppFilterChip extends StatelessWidget {
  const AppFilterChip({super.key, required this.label, required this.isSelected, required this.onTap});

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(responsive.radius(24)),
      child: Container(
        padding: responsive.padding(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(responsive.radius(24)),
        ),
        child: Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            fontWeight: FontWeight.w500,
            color: isSelected ? AppColors.textOnPrimary : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
