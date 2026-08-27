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

class EnableLocationScreen extends StatelessWidget {
  const EnableLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              left: responsive.spacing(30),
              top: responsive.spacing(20),
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
            Center(
              child: Padding(
                padding: responsive.padding(horizontal: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _ConcentricCircles(
                      child: SvgPicture.asset(
                        AppAssets.locationPin,
                        width: responsive.iconSize(49),
                        height: responsive.iconSize(49),
                        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                      ),
                    ),
                    SizedBox(height: responsive.spacing(32)),
                    Text(
                      AppStrings.enableLocationTitle,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.headlineMedium.copyWith(color: AppColors.textPrimary, fontSize: 24),
                    ),
                    SizedBox(height: responsive.spacing(12)),
                    Text(
                      AppStrings.enableLocationSubtitle,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.bodyMedium.copyWith(color: const Color(0xFF4A4646), fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: responsive.spacing(30),
              right: responsive.spacing(30),
              bottom: responsive.spacing(24),
              child: Column(
                children: [
                  AppButton(
                    label: AppStrings.allowLocationAccess,
                    icon: Icons.my_location_rounded,
                    onPressed: () => context.go(AppRoutes.home),
                  ),
                  SizedBox(height: responsive.spacing(12)),
                  AppButton(
                    label: AppStrings.enterAddressManually,
                    variant: AppButtonVariant.outline,
                    large: true,
                    onPressed: () => context.push(AppRoutes.selectAddress),
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

class _ConcentricCircles extends StatelessWidget {
  const _ConcentricCircles({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Container(
      width: responsive.size(261),
      height: responsive.size(261),
      decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.4), shape: BoxShape.circle),
      child: Center(
        child: Container(
          width: responsive.size(226),
          height: responsive.size(226),
          decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.6), shape: BoxShape.circle),
          child: Center(
            child: Container(
              width: responsive.size(185),
              height: responsive.size(185),
              decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.8), shape: BoxShape.circle),
              child: Center(
                child: Container(
                  width: responsive.size(96),
                  height: responsive.size(96),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: const Color(0x662E7D32), blurRadius: responsive.spacing(12), offset: Offset(0, responsive.spacing(8))),
                    ],
                  ),
                  child: Center(child: child),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
