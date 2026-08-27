import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/widgets/info_field.dart';
import '../../dashboard/state/host_mock_data.dart';

/// Read-only "Business Details" view (Figma node 502:13290's Business
/// Details menu destination): business name, tax ID, and address.
class BusinessDetailsScreen extends StatelessWidget {
  const BusinessDetailsScreen({super.key});

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
                  Text(AppStrings.hostBusinessDetails, style: AppTextStyles.titleLarge),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: responsive.padding(horizontal: 16, vertical: 16),
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
                        InfoField(label: AppStrings.hostBusinessName, value: profile.businessName),
                        SizedBox(height: responsive.spacing(10)),
                        InfoField(label: AppStrings.hostTaxId, value: profile.businessTaxId),
                        SizedBox(height: responsive.spacing(10)),
                        InfoField(label: AppStrings.hostBusinessAddress, value: profile.businessAddress),
                      ],
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
