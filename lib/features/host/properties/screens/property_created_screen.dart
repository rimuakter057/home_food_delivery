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

/// The "Property Created!" confirmation (Figma node 521:7504) shown after
/// saving a new property, with the generated share code.
class PropertyCreatedScreen extends StatelessWidget {
  const PropertyCreatedScreen({super.key});

  static const _generatedCode = 'PHX5784';

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
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
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: responsive.size(96),
                          height: responsive.size(96),
                          decoration: const BoxDecoration(color: AppColors.tealSurface, shape: BoxShape.circle),
                          child: Center(
                            child: SvgPicture.asset(AppAssets.propertyBuildingSmall, width: responsive.iconSize(40), height: responsive.iconSize(40)),
                          ),
                        ),
                        SizedBox(height: responsive.spacing(16)),
                        Text(
                          AppStrings.hostPropertyCreatedTitle,
                          style: AppTextStyles.headlineMedium.copyWith(color: AppColors.textPrimary, fontSize: 24),
                        ),
                        SizedBox(height: responsive.spacing(6)),
                        Text(
                          AppStrings.hostPropertyCreatedSubtitle,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
                        ),
                        SizedBox(height: responsive.spacing(24)),
                        Container(
                          width: double.infinity,
                          padding: responsive.padding(all: 24),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            border: Border.all(color: AppColors.divider),
                            borderRadius: BorderRadius.circular(responsive.radius(8)),
                          ),
                          child: Column(
                            children: [
                              Text(
                                AppStrings.hostPropertyCode,
                                style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: responsive.spacing(12)),
                              Text(_generatedCode, style: AppTextStyles.codeLarge.copyWith(color: AppColors.tealText)),
                              SizedBox(height: responsive.spacing(12)),
                              Row(
                                children: [
                                  Expanded(
                                    child: AppButton(label: AppStrings.hostCopyCode, variant: AppButtonVariant.outline, onPressed: () {}),
                                  ),
                                  SizedBox(width: responsive.spacing(10)),
                                  Expanded(
                                    child: AppButton(label: AppStrings.hostShareCodeButton, onPressed: () {}),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: responsive.spacing(32)),
                        AppButton(
                          label: AppStrings.hostGoToMyProperties,
                          variant: AppButtonVariant.outline,
                          large: true,
                          onPressed: () {
                            context.read<HostNavigationState>().setIndex(1);
                            context.go(AppRoutes.hostHome);
                          },
                        ),
                      ],
                    ),
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
