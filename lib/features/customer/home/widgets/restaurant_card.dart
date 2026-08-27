import 'package:flutter/material.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/rating_badge.dart';
import '../state/home_models.dart';

class RestaurantCard extends StatelessWidget {
  const RestaurantCard({super.key, required this.restaurant, required this.onTap});

  final RestaurantModel restaurant;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return SizedBox(
      width: responsive.size(220),
      child: AppCard(
        onTap: onTap,
        padding: responsive.padding(all: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 2.2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(responsive.radius(16)),
                    child: Image.asset(AppAssets.storeThumbFreshProduce, fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  top: responsive.spacing(8),
                  right: responsive.spacing(8),
                  child: Container(
                    padding: responsive.padding(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: (restaurant.isOpen ? AppColors.success : AppColors.error)
                          .withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(responsive.radius(8)),
                    ),
                    child: Text(
                      restaurant.isOpen ? AppStrings.openNow : AppStrings.closedNow,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: responsive.fontSize(10),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: responsive.spacing(8)),
            Text(
              restaurant.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: responsive.fontSize(14), fontWeight: FontWeight.w700),
            ),
            SizedBox(height: responsive.spacing(2)),
            Text(
              restaurant.cuisine,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: responsive.fontSize(11), color: AppColors.textSecondary),
            ),
            SizedBox(height: responsive.spacing(6)),
            Row(
              children: [
                RatingBadge(rating: restaurant.rating, compact: true),
                SizedBox(width: responsive.spacing(8)),
                Icon(Icons.timer_outlined, size: responsive.iconSize(13), color: AppColors.textSecondary),
                SizedBox(width: responsive.spacing(3)),
                Text(
                  '${restaurant.deliveryTimeMinutes} ${AppStrings.minutes}',
                  style: TextStyle(fontSize: responsive.fontSize(11), color: AppColors.textSecondary),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
