import 'package:flutter/material.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/widgets/app_card.dart';
import '../state/home_models.dart';

/// The "Featured Items" product card from the Figma Home screen
/// (node 493:4729): image, name, price, and a circular add-to-cart button.
class FoodCard extends StatelessWidget {
  const FoodCard({super.key, required this.food, required this.onTap, this.onAdd});

  final FoodModel food;
  final VoidCallback onTap;
  final VoidCallback? onAdd;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return SizedBox(
      width: responsive.size(160),
      child: AppCard(
        onTap: onTap,
        padding: responsive.padding(all: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(responsive.radius(16)),
                child: Image.asset(AppAssets.foodPhotoGeneric, fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: responsive.spacing(8)),
            Text(food.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.titleSmall),
            SizedBox(height: responsive.spacing(4)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${AppStrings.currencySymbol}${food.price.toStringAsFixed(2)}',
                  style: AppTextStyles.titleSmall.copyWith(color: AppColors.primary),
                ),
                InkWell(
                  onTap: onAdd ?? onTap,
                  borderRadius: BorderRadius.circular(responsive.radius(12)),
                  child: Container(
                    width: responsive.size(24),
                    height: responsive.size(24),
                    decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                    child: Icon(Icons.add_rounded, size: responsive.iconSize(16), color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
