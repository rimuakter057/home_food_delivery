import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/widgets/app_button.dart';

/// The Shopper "Application Under Review" status screen (Figma node
/// 180:8488) — the landing screen once the wizard is submitted, and where
/// a returning Shopper lands after signing back in before approval.
class ShopperApplicationPendingScreen extends StatelessWidget {
  const ShopperApplicationPendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: responsive.padding(horizontal: 30, vertical: 18),
              decoration: BoxDecoration(
                color: AppColors.primaryDark,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(responsive.radius(24))),
              ),
              child: Row(
                children: [
                  Image.asset(AppAssets.brandLogo, width: responsive.size(48)),
                  SizedBox(width: responsive.spacing(12)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppStrings.appName, style: AppTextStyles.titleSmall.copyWith(color: Colors.white, fontSize: 16, height: 28 / 16)),
                      Text(AppStrings.shopperPortalSubtitle, style: AppTextStyles.bodySmall.copyWith(color: Colors.white.withValues(alpha: 0.8))),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: responsive.padding(horizontal: 30, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: responsive.size(114),
                              height: responsive.size(114),
                              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.ratingStar, width: 2)),
                            ),
                            Container(
                              width: responsive.size(96),
                              height: responsive.size(96),
                              decoration: const BoxDecoration(color: Color(0xFFFFF8E1), shape: BoxShape.circle),
                              child: Center(child: SvgPicture.asset(AppAssets.shopperClockIcon, width: responsive.iconSize(48), height: responsive.iconSize(48))),
                            ),
                          ],
                        ),
                        SizedBox(height: responsive.spacing(24)),
                        Text(AppStrings.shopperUnderReviewTitle, textAlign: TextAlign.center, style: AppTextStyles.titleSmall.copyWith(fontSize: 24, height: 1.2)),
                        SizedBox(height: responsive.spacing(6)),
                        Text(
                          AppStrings.shopperUnderReviewSubtitle,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.bodySmall.copyWith(fontSize: 12, height: 20 / 12),
                        ),
                      ],
                    ),
                    SizedBox(height: responsive.spacing(32)),
                    Container(
                      width: double.infinity,
                      padding: responsive.padding(all: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF8E1),
                        border: Border.all(color: AppColors.ratingStar, width: 0.5),
                        borderRadius: BorderRadius.circular(responsive.radius(8)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: responsive.size(40),
                                height: responsive.size(40),
                                decoration: const BoxDecoration(color: AppColors.ratingStar, shape: BoxShape.circle),
                                child: Center(child: Text('⏳', style: TextStyle(fontSize: responsive.fontSize(15.3), color: Colors.white))),
                              ),
                              SizedBox(width: responsive.spacing(12)),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(AppStrings.shopperStatusPendingApproval, style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold)),
                                    Text(AppStrings.shopperSubmittedOn, style: AppTextStyles.bodySmall),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: responsive.spacing(12)),
                          _ChecklistRow(icon: AppAssets.shopperCheckTiny, background: const Color(0xFFE8F5E9), label: AppStrings.shopperChecklistPersonalInfoVerified, color: AppColors.primary),
                          SizedBox(height: responsive.spacing(8)),
                          _ChecklistRow(icon: AppAssets.shopperCheckTiny, background: const Color(0xFFE8F5E9), label: AppStrings.shopperChecklistVehicleDetailsReceived, color: AppColors.primary),
                          SizedBox(height: responsive.spacing(8)),
                          _ChecklistRow(icon: AppAssets.shopperHourglassTiny, background: const Color(0xFFFFF8E1), label: AppStrings.shopperChecklistDocumentsUnderReview, color: AppColors.ratingStar),
                          SizedBox(height: responsive.spacing(8)),
                          _ChecklistRow(icon: null, background: const Color(0xFFF5F5F5), label: AppStrings.shopperChecklistBackgroundCheck, color: AppColors.textPlaceholder),
                        ],
                      ),
                    ),
                    SizedBox(height: responsive.spacing(16)),
                    Container(
                      width: double.infinity,
                      padding: responsive.padding(all: 12),
                      decoration: BoxDecoration(color: AppColors.linkBadgeBackground, borderRadius: BorderRadius.circular(responsive.radius(8))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppStrings.shopperWhatHappensNextTitle, style: AppTextStyles.titleSmall.copyWith(color: AppColors.link, fontWeight: FontWeight.bold)),
                          SizedBox(height: responsive.spacing(8)),
                          Text('•  ${AppStrings.shopperNextStep1}', style: AppTextStyles.bodySmall.copyWith(color: AppColors.link)),
                          SizedBox(height: responsive.spacing(4)),
                          Text('•  ${AppStrings.shopperNextStep2}', style: AppTextStyles.bodySmall.copyWith(color: AppColors.link)),
                          SizedBox(height: responsive.spacing(4)),
                          Text('•  ${AppStrings.shopperNextStep3}', style: AppTextStyles.bodySmall.copyWith(color: AppColors.link)),
                        ],
                      ),
                    ),
                    SizedBox(height: responsive.spacing(16)),
                    Container(
                      width: double.infinity,
                      padding: responsive.padding(all: 12),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(responsive.radius(8)),
                        boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: responsive.spacing(4), offset: Offset(0, responsive.spacing(2)))],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppStrings.shopperNeedHelp, style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.w500)),
                          SizedBox(height: responsive.spacing(10)),
                          _HelpButton(icon: AppAssets.shopperEmailIcon, label: AppStrings.shopperSupportEmail),
                          SizedBox(height: responsive.spacing(8)),
                          _HelpButton(icon: AppAssets.shopperPhoneIcon, label: AppStrings.shopperSupportPhone),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: responsive.padding(horizontal: 30, vertical: 12).copyWith(bottom: responsive.spacing(20)),
              child: Column(
                children: [
                  AppButton(
                    label: AppStrings.shopperCheckStatus,
                    icon: Icons.refresh_rounded,
                    onPressed: () {},
                  ),
                  SizedBox(height: responsive.spacing(12)),
                  SizedBox(
                    width: double.infinity,
                    height: responsive.size(48),
                    child: OutlinedButton(
                      onPressed: () => context.go(AppRoutes.roleLanding),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColors.divider),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(responsive.radius(8))),
                      ),
                      child: Text(AppStrings.shopperSignOut, style: AppTextStyles.buttonLabel.copyWith(color: AppColors.textSecondary)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChecklistRow extends StatelessWidget {
  const _ChecklistRow({required this.icon, required this.background, required this.label, required this.color});

  final String? icon;
  final Color background;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Row(
      children: [
        Container(
          width: responsive.size(24),
          height: responsive.size(24),
          decoration: BoxDecoration(color: background, shape: BoxShape.circle),
          child: icon != null
              ? Center(child: SvgPicture.asset(icon!, width: responsive.iconSize(14), height: responsive.iconSize(14)))
              : Center(
                  child: Container(
                    width: responsive.size(8),
                    height: responsive.size(8),
                    decoration: const BoxDecoration(color: AppColors.textPlaceholder, shape: BoxShape.circle),
                  ),
                ),
        ),
        SizedBox(width: responsive.spacing(4)),
        Text(label, style: AppTextStyles.bodySmall.copyWith(color: color)),
      ],
    );
  }
}

class _HelpButton extends StatelessWidget {
  const _HelpButton({required this.icon, required this.label});

  final String icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          padding: responsive.padding(horizontal: 12, vertical: 6),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(responsive.radius(8))),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(icon, width: responsive.iconSize(16), height: responsive.iconSize(16)),
            SizedBox(width: responsive.spacing(6)),
            Text(label, style: AppTextStyles.bodySmall.copyWith(color: AppColors.primary)),
          ],
        ),
      ),
    );
  }
}
