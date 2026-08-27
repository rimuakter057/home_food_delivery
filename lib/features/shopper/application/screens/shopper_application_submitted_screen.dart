import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/widgets/app_button.dart';
import '../widgets/shopper_wizard_header.dart';

/// Shopper Application step 4/4 (Figma node 180:8094): confirmation with a
/// received-items checklist, then hands off to the pending-review screen.
class ShopperApplicationSubmittedScreen extends StatelessWidget {
  const ShopperApplicationSubmittedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          ShopperWizardHeader(step: 4, totalSteps: 4, stepLabel: AppStrings.shopperStepSubmitted, onBack: () => context.pop()),
          Expanded(
            child: SingleChildScrollView(
              padding: responsive.padding(horizontal: 30, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    children: [
                      Container(
                        width: responsive.size(112),
                        height: responsive.size(112),
                        decoration: const BoxDecoration(color: Color(0xFFE3F2FD), shape: BoxShape.circle),
                        child: Center(child: Text('🎉', style: TextStyle(fontSize: responsive.fontSize(48)))),
                      ),
                      SizedBox(height: responsive.spacing(24)),
                      Text(
                        AppStrings.shopperApplicationSubmittedTitle,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.titleSmall.copyWith(fontSize: 24, height: 1.2),
                      ),
                      SizedBox(height: responsive.spacing(6)),
                      Text(
                        AppStrings.shopperApplicationSubmittedSubtitle,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodySmall.copyWith(fontSize: 12, height: 20 / 12),
                      ),
                    ],
                  ),
                  SizedBox(height: responsive.spacing(32)),
                  Container(
                    width: double.infinity,
                    padding: responsive.padding(all: 12),
                    decoration: BoxDecoration(color: AppColors.linkBadgeBackground, borderRadius: BorderRadius.circular(responsive.radius(8))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: responsive.size(40),
                              height: responsive.size(40),
                              decoration: const BoxDecoration(color: AppColors.link, shape: BoxShape.circle),
                              child: Center(child: Text('⏳', style: TextStyle(fontSize: responsive.fontSize(15.3), color: Colors.white))),
                            ),
                            SizedBox(width: responsive.spacing(12)),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(AppStrings.shopperStatusPendingReview, style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold)),
                                  Text(AppStrings.shopperPendingReviewSubtitle, style: AppTextStyles.bodySmall),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: responsive.spacing(12)),
                        Text(AppStrings.shopperChecklistPersonalInfo, style: AppTextStyles.bodySmall.copyWith(color: AppColors.link)),
                        SizedBox(height: responsive.spacing(4)),
                        Text(AppStrings.shopperChecklistVehicleDetails, style: AppTextStyles.bodySmall.copyWith(color: AppColors.link)),
                        SizedBox(height: responsive.spacing(4)),
                        Text(AppStrings.shopperChecklistDocuments, style: AppTextStyles.bodySmall.copyWith(color: AppColors.link)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: responsive.padding(horizontal: 30, vertical: 20),
            child: AppButton(label: AppStrings.shopperGoToPendingScreen, onPressed: () => context.go(AppRoutes.shopperPending)),
          ),
        ],
      ),
    );
  }
}
