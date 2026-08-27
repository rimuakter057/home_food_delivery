import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/app_assets.dart';
import '../constants/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../utils/responsive_helper.dart';

/// Plain star + number, matching the Figma store card rating (no pill
/// background — just an inline icon and Inter Medium label).
class RatingBadge extends StatelessWidget {
  const RatingBadge({super.key, required this.rating, this.compact = false});

  final double rating;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final size = responsive.iconSize(compact ? 12 : 16);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          AppAssets.starRating,
          width: size,
          height: size,
          colorFilter: const ColorFilter.mode(AppColors.ratingStar, BlendMode.srcIn),
        ),
        SizedBox(width: responsive.spacing(4)),
        Text(
          rating.toStringAsFixed(1),
          style: AppTextStyles.labelSmall.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w500,
            fontSize: responsive.fontSize(compact ? 11 : 12),
          ),
        ),
      ],
    );
  }
}
