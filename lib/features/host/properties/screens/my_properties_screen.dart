import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../state/property_mock_data.dart';
import '../state/property_models.dart';

/// The Host "My Properties" list (Figma node 496:11874): a photo card per
/// property with its code, active-delivery count, and a Manage shortcut.
class MyPropertiesScreen extends StatelessWidget {
  const MyPropertiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
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
                  Text(AppStrings.hostMyProperties, style: AppTextStyles.titleLarge),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () => context.push(AppRoutes.hostAddProperty),
                      borderRadius: BorderRadius.circular(responsive.radius(13)),
                      child: Container(
                        width: responsive.size(26),
                        height: responsive.size(26),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(color: const Color(0x1A000000), blurRadius: responsive.spacing(2), offset: Offset(0, responsive.spacing(2))),
                            BoxShadow(color: const Color(0x1A000000), blurRadius: responsive.spacing(3), offset: Offset(0, responsive.spacing(4))),
                          ],
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            AppAssets.hostAddPlus,
                            width: responsive.iconSize(16),
                            height: responsive.iconSize(16),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: responsive.padding(horizontal: 16, vertical: 8),
                itemCount: PropertyMockData.properties.length,
                separatorBuilder: (_, __) => SizedBox(height: responsive.spacing(12)),
                itemBuilder: (context, index) {
                  final property = PropertyMockData.properties[index];
                  return _PropertyCard(
                    property: property,
                    onTap: () => context.push(AppRoutes.hostPropertyDetailPath(property.id)),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PropertyCard extends StatelessWidget {
  const _PropertyCard({required this.property, required this.onTap});

  final PropertyModel property;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(responsive.radius(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(responsive.radius(8)),
              topRight: Radius.circular(responsive.radius(8)),
            ),
            child: Stack(
              children: [
                Image.asset(property.image, width: double.infinity, height: responsive.size(118), fit: BoxFit.cover),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      padding: responsive.padding(horizontal: 16, vertical: 6),
                      color: Colors.black.withValues(alpha: 0.32),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(property.name, style: AppTextStyles.titleSmall.copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                          Container(
                            padding: responsive.padding(horizontal: 8, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
                              borderRadius: BorderRadius.circular(responsive.radius(4)),
                            ),
                            child: Text(property.type, style: AppTextStyles.labelSmall.copyWith(color: Colors.white, fontWeight: FontWeight.w500)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: responsive.padding(all: 12),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(responsive.radius(8)),
                bottomRight: Radius.circular(responsive.radius(8)),
              ),
              boxShadow: [
                BoxShadow(color: AppColors.cardShadow, blurRadius: responsive.spacing(4), offset: Offset(0, responsive.spacing(2))),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      AppAssets.locationPinSmall,
                      width: responsive.iconSize(16),
                      height: responsive.iconSize(16),
                      colorFilter: const ColorFilter.mode(AppColors.textSecondary, BlendMode.srcIn),
                    ),
                    SizedBox(width: responsive.spacing(12)),
                    Expanded(child: Text(property.address, style: AppTextStyles.bodySmall)),
                  ],
                ),
                SizedBox(height: responsive.spacing(12)),
                Container(
                  width: double.infinity,
                  padding: responsive.padding(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.border, width: 0.5),
                    borderRadius: BorderRadius.circular(responsive.radius(8)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppStrings.hostPropertyCode, style: AppTextStyles.bodySmall),
                          Text(
                            property.code,
                            style: AppTextStyles.titleSmall.copyWith(color: AppColors.tealText, fontWeight: FontWeight.bold, fontSize: 16, height: 28 / 16),
                          ),
                        ],
                      ),
                      SvgPicture.asset(AppAssets.hostCopyIcon, width: responsive.iconSize(20), height: responsive.iconSize(20)),
                    ],
                  ),
                ),
                SizedBox(height: responsive.spacing(12)),
                Divider(color: AppColors.textPlaceholder, height: 1),
                SizedBox(height: responsive.spacing(12)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: responsive.size(8),
                          height: responsive.size(8),
                          decoration: const BoxDecoration(color: AppColors.ratingStar, shape: BoxShape.circle),
                        ),
                        SizedBox(width: responsive.spacing(4)),
                        Text(
                          '${property.activeDeliveries} ${AppStrings.hostActiveDeliveries}',
                          style: AppTextStyles.labelSmall.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Text(AppStrings.hostManage, style: AppTextStyles.labelSmall.copyWith(color: AppColors.tealText, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
