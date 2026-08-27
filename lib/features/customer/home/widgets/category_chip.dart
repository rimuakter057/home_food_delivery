import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../state/home_models.dart';

/// The 56x56 rounded-square category tile from the Figma Home screen
/// (node 493:4675): mint fill + primary border when selected, white +
/// light gray border otherwise.
class CategoryChip extends StatelessWidget {
  const CategoryChip({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  final CategoryModel category;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: responsive.size(56),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: responsive.size(56),
              height: responsive.size(56),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFE8F5E9) : AppColors.surface,
                borderRadius: BorderRadius.circular(responsive.radius(8)),
                border: Border.all(color: isSelected ? AppColors.primary : AppColors.divider, width: 1.5),
                boxShadow: [
                  BoxShadow(color: AppColors.cardShadow, blurRadius: responsive.spacing(4), offset: Offset(0, responsive.spacing(2))),
                ],
              ),
              child: Center(
                child: Text(category.emoji, style: TextStyle(fontSize: responsive.fontSize(20))),
              ),
            ),
            SizedBox(height: responsive.spacing(4)),
            Text(
              category.name,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.labelSmall.copyWith(
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
