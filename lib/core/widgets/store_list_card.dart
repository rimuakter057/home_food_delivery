import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/app_assets.dart';
import '../constants/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../utils/responsive_helper.dart';
import 'app_card.dart';
import 'rating_badge.dart';

/// The repeated store/item row from the Figma "Element" library (node
/// 82:3834) and the Browse Stores screen (node 493:4907): a 56x56 thumbnail,
/// title + rating on the left, and a trailing delivery-fee/price label.
class StoreListCard extends StatelessWidget {
  const StoreListCard({
    super.key,
    required this.image,
    required this.title,
    required this.rating,
    required this.trailingLabel,
    this.trailingIsFree = false,
    this.onTap,
  });

  final Widget image;
  final String title;
  final double rating;
  final String trailingLabel;

  /// Figma colors "Free" in primary green and a priced fee (e.g. "$10.00")
  /// in the link blue — pass `true` for the former.
  final bool trailingIsFree;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return AppCard(
      onTap: onTap,
      child: SizedBox(
        height: responsive.size(56),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(responsive.radius(8)),
              child: Container(
                width: responsive.size(56),
                height: responsive.size(56),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.divider),
                  borderRadius: BorderRadius.circular(responsive.radius(8)),
                ),
                child: image,
              ),
            ),
            SizedBox(width: responsive.spacing(12)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.titleSmall),
                  RatingBadge(rating: rating),
                ],
              ),
            ),
            SizedBox(width: responsive.spacing(12)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  AppAssets.chevronRightSmall,
                  width: responsive.iconSize(16),
                  height: responsive.iconSize(16),
                  colorFilter: const ColorFilter.mode(AppColors.textSecondary, BlendMode.srcIn),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      AppAssets.deliveryTruck,
                      width: responsive.iconSize(12),
                      height: responsive.iconSize(12),
                      colorFilter: ColorFilter.mode(
                        trailingIsFree ? AppColors.primary : AppColors.link,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: responsive.spacing(4)),
                    Text(
                      trailingLabel,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: trailingIsFree ? AppColors.primary : AppColors.link,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
