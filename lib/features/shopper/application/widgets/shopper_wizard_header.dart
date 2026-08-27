import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_helper.dart';

/// The green progress header shared by every "Shopper Application" wizard
/// step (Figma nodes 179:6938 / 180:7136 / 180:7576 / 180:8094): back
/// chevron + step counter, a progress bar, and an icon/title/step-name row.
/// Pass [overlapping] (the Sign In / Sign Up tab switcher) for step 1 only.
class ShopperWizardHeader extends StatelessWidget {
  const ShopperWizardHeader({
    super.key,
    required this.step,
    required this.totalSteps,
    required this.stepLabel,
    this.icon = '🚴',
    this.onBack,
    this.overlapping,
  });

  final int step;
  final int totalSteps;
  final String stepLabel;
  final String icon;
  final VoidCallback? onBack;
  final Widget? overlapping;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: double.infinity,
          padding: responsive.padding(horizontal: 30, vertical: 20),
          decoration: BoxDecoration(
            color: AppColors.primaryDark,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(responsive.radius(24))),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: onBack ?? () => Navigator.of(context).maybePop(),
                    borderRadius: BorderRadius.circular(responsive.radius(12)),
                    child: SvgPicture.asset(
                      AppAssets.chevronBack,
                      width: responsive.iconSize(24),
                      height: responsive.iconSize(24),
                      colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    ),
                  ),
                  Text(
                    '${AppStrings.shopperStepLabel} $step/$totalSteps',
                    style: AppTextStyles.labelSmall.copyWith(color: Colors.white.withValues(alpha: 0.8), fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(height: responsive.spacing(12)),
              ClipRRect(
                borderRadius: BorderRadius.circular(responsive.radius(9999)),
                child: LinearProgressIndicator(
                  value: step / totalSteps,
                  minHeight: responsive.size(6),
                  backgroundColor: Colors.white.withValues(alpha: 0.2),
                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF4FC3F7)),
                ),
              ),
              SizedBox(height: responsive.spacing(12)),
              Row(
                children: [
                  Container(
                    width: responsive.size(40),
                    height: responsive.size(40),
                    decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(responsive.radius(8))),
                    child: Center(child: Text(icon, style: TextStyle(fontSize: responsive.fontSize(17)))),
                  ),
                  SizedBox(width: responsive.spacing(12)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppStrings.shopperApplicationTitle, style: AppTextStyles.titleSmall.copyWith(color: Colors.white, fontSize: 16, height: 28 / 16)),
                      Text(stepLabel, style: AppTextStyles.bodySmall.copyWith(color: Colors.white.withValues(alpha: 0.8))),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        if (overlapping != null) Positioned(bottom: responsive.spacing(-29), child: overlapping!),
      ],
    );
  }
}
