import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../dashboard/state/host_mock_data.dart';

/// The Host "My Profile" screen (Figma node 502:13290): avatar header over
/// a menu list reusing the same Help & Support / Privacy & Security screens
/// as the customer flow.
class HostProfileScreen extends StatelessWidget {
  const HostProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final profile = HostMockData.profile;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              width: double.infinity,
              padding: responsive.padding(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: AppColors.primaryDark,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(responsive.radius(24)),
                  bottomRight: Radius.circular(responsive.radius(24)),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppStrings.hostMyProfile, textAlign: TextAlign.center, style: AppTextStyles.titleLarge.copyWith(color: Colors.white)),
                  SizedBox(height: responsive.spacing(24)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: responsive.size(64),
                            height: responsive.size(64),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: const Color(0xFFE0E0E0), width: 2),
                            ),
                            child: ClipOval(
                              child: Image.asset(AppAssets.hostAvatar, fit: BoxFit.cover),
                            ),
                          ),
                          SizedBox(width: responsive.spacing(12)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(profile.ownerName, style: AppTextStyles.titleSmall.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                              Text(profile.email, style: AppTextStyles.bodySmall.copyWith(color: const Color(0xFFE0E0E0))),
                              SizedBox(height: responsive.spacing(4)),
                              Text(profile.phone, style: AppTextStyles.caption.copyWith(color: Colors.white, fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () => context.push(AppRoutes.hostEditProfile),
                        borderRadius: BorderRadius.circular(responsive.radius(8)),
                        child: Container(
                          padding: responsive.padding(horizontal: 11, vertical: 6),
                          decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(responsive.radius(8))),
                          child: Text(AppStrings.hostEdit, style: AppTextStyles.labelSmall.copyWith(color: AppColors.primary)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: responsive.padding(horizontal: 16, vertical: 16),
              child: Column(
                children: [
                  _MenuTile(icon: AppAssets.hostMenuPersonal, background: const Color(0xFFE8F5E9), label: AppStrings.hostPersonalInformation, onTap: () => context.push(AppRoutes.hostPersonalInformation)),
                  SizedBox(height: responsive.spacing(12)),
                  _MenuTile(icon: AppAssets.hostMenuBusiness, background: const Color(0xFFE3F2FD), label: AppStrings.hostBusinessDetails, onTap: () => context.push(AppRoutes.hostBusinessDetails)),
                  SizedBox(height: responsive.spacing(12)),
                  _MenuTile(icon: AppAssets.hostMenuNotifications, background: const Color(0xFFFFF8E1), label: AppStrings.hostNotifications, iconSize: 18, onTap: () => context.push(AppRoutes.hostNotifications)),
                  SizedBox(height: responsive.spacing(12)),
                  _MenuTile(icon: AppAssets.hostMenuPrivacy, background: const Color(0xFFF3E5F5), label: AppStrings.hostPrivacySecurity, iconSize: 18, onTap: () => context.push(AppRoutes.privacySecurity)),
                  SizedBox(height: responsive.spacing(12)),
                  _MenuTile(icon: AppAssets.hostMenuHelp, background: const Color(0xFFF5F5F5), label: AppStrings.hostHelpSupport, iconSize: 18, onTap: () => context.push(AppRoutes.helpSupport)),
                  SizedBox(height: responsive.spacing(24)),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => context.go(AppRoutes.roleLanding),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFEBEE),
                        side: const BorderSide(color: AppColors.error),
                        padding: responsive.padding(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(responsive.radius(8))),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(AppAssets.hostSignoutIcon, width: responsive.iconSize(16), height: responsive.iconSize(16)),
                          SizedBox(width: responsive.spacing(12)),
                          Text(AppStrings.hostSignOut, style: AppTextStyles.titleSmall.copyWith(color: AppColors.error)),
                        ],
                      ),
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

class _MenuTile extends StatelessWidget {
  const _MenuTile({required this.icon, required this.background, required this.label, required this.onTap, this.iconSize = 20});

  final String icon;
  final Color background;
  final String label;
  final VoidCallback onTap;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(responsive.radius(8)),
      child: Container(
        width: double.infinity,
        padding: responsive.padding(all: 12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(responsive.radius(8)),
          boxShadow: [BoxShadow(color: const Color(0x0F000000), blurRadius: responsive.spacing(4), offset: Offset(0, responsive.spacing(2)))],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: responsive.size(40),
                  height: responsive.size(40),
                  decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(responsive.radius(8))),
                  child: Center(child: SvgPicture.asset(icon, width: responsive.iconSize(iconSize), height: responsive.iconSize(iconSize))),
                ),
                SizedBox(width: responsive.spacing(12)),
                Text(label, style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.w500)),
              ],
            ),
            SvgPicture.asset(AppAssets.chevronRightSmall, width: responsive.iconSize(20), height: responsive.iconSize(20)),
          ],
        ),
      ),
    );
  }
}
