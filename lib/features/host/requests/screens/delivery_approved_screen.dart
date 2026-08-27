import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/widgets/app_button.dart';
import '../../navigation/state/host_navigation_state.dart';
import '../state/request_mock_data.dart';

/// The "Delivery Approved!" confirmation (Figma node 521:7346).
class DeliveryApprovedScreen extends StatelessWidget {
  const DeliveryApprovedScreen({super.key, required this.requestId});

  final String requestId;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final request = RequestMockData.byId(requestId);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: responsive.padding(horizontal: 16),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: responsive.padding(vertical: 8),
                  child: InkWell(
                    onTap: () => context.pop(),
                    borderRadius: BorderRadius.circular(responsive.radius(12)),
                    child: SvgPicture.asset(
                      AppAssets.chevronBack,
                      width: responsive.iconSize(24),
                      height: responsive.iconSize(24),
                      colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: responsive.size(96),
                        height: responsive.size(96),
                        decoration: const BoxDecoration(color: AppColors.tealSurface, shape: BoxShape.circle),
                        child: Center(child: Icon(Icons.check_circle_outline_rounded, size: responsive.iconSize(48), color: AppColors.tealText)),
                      ),
                      SizedBox(height: responsive.spacing(16)),
                      Text(AppStrings.hostDeliveryApprovedTitle, style: AppTextStyles.headlineMedium.copyWith(color: AppColors.textPrimary, fontSize: 24)),
                      SizedBox(height: responsive.spacing(6)),
                      Text(AppStrings.hostDeliveryApprovedSubtitle, style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary)),
                      SizedBox(height: responsive.spacing(24)),
                      Container(
                        padding: responsive.padding(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(color: AppColors.tealSurface, borderRadius: BorderRadius.circular(responsive.radius(8))),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.calendar_today_outlined, size: responsive.iconSize(14), color: AppColors.tealText),
                            SizedBox(width: responsive.spacing(8)),
                            Text(request.requestedDate, style: AppTextStyles.labelSmall.copyWith(color: AppColors.tealText, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      SizedBox(height: responsive.spacing(32)),
                      Container(
                        width: double.infinity,
                        padding: responsive.padding(all: 24),
                        decoration: BoxDecoration(color: const Color(0xFFF5F5F5), border: Border.all(color: AppColors.divider), borderRadius: BorderRadius.circular(responsive.radius(8))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppStrings.hostWhatHappensNext, style: AppTextStyles.titleSmall.copyWith(color: AppColors.textSecondary)),
                            SizedBox(height: responsive.spacing(12)),
                            Text(AppStrings.hostNextStep1, style: AppTextStyles.bodySmall),
                            SizedBox(height: responsive.spacing(8)),
                            Text(AppStrings.hostNextStep2, style: AppTextStyles.bodySmall),
                            SizedBox(height: responsive.spacing(8)),
                            Text(AppStrings.hostNextStep3, style: AppTextStyles.bodySmall),
                            SizedBox(height: responsive.spacing(8)),
                            Text(AppStrings.hostNextStep4, style: AppTextStyles.bodySmall),
                          ],
                        ),
                      ),
                      SizedBox(height: responsive.spacing(32)),
                      AppButton(
                        label: AppStrings.hostViewSchedule,
                        large: true,
                        onPressed: () {
                          context.read<HostNavigationState>().setIndex(2);
                          context.go(AppRoutes.hostHome);
                        },
                      ),
                      SizedBox(height: responsive.spacing(16)),
                      AppButton(
                        label: AppStrings.hostBackToRequests,
                        variant: AppButtonVariant.outline,
                        large: true,
                        onPressed: () {
                          context.read<HostNavigationState>().setIndex(2);
                          context.go(AppRoutes.hostHome);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
