import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/widgets/info_field.dart';
import '../../dashboard/state/host_mock_data.dart';

/// Read-only "Personal Information" view (Figma node 521:8647) with a
/// shortcut into the editable form.
class PersonalInformationScreen extends StatelessWidget {
  const PersonalInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final profile = HostMockData.profile;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: responsive.padding(horizontal: 16, vertical: 8),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
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
                  Text(AppStrings.hostPersonalInformation, style: AppTextStyles.titleLarge),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: responsive.padding(horizontal: 16, vertical: 16),
                children: [
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: responsive.padding(all: 12),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(responsive.radius(8)),
                          boxShadow: [BoxShadow(color: const Color(0x0F000000), blurRadius: responsive.spacing(4), offset: Offset(0, responsive.spacing(2)))],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InfoField(label: AppStrings.hostFullName, value: profile.ownerName),
                            SizedBox(height: responsive.spacing(10)),
                            InfoField(label: AppStrings.hostEmailAddress, value: profile.email),
                            SizedBox(height: responsive.spacing(10)),
                            InfoField(label: AppStrings.hostPhone, value: profile.phone),
                          ],
                        ),
                      ),
                      Positioned(
                        top: responsive.spacing(12),
                        right: responsive.spacing(12),
                        child: InkWell(
                          onTap: () => context.push(AppRoutes.hostEditProfile),
                          borderRadius: BorderRadius.circular(responsive.radius(8)),
                          child: Container(
                            padding: responsive.padding(horizontal: 11, vertical: 6),
                            decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(responsive.radius(8))),
                            child: Text(AppStrings.hostEdit, style: AppTextStyles.labelSmall.copyWith(color: AppColors.primary)),
                          ),
                        ),
                      ),
                    ],
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
