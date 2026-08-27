import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../state/shopper_profile_mock_data.dart';

/// The Shopper "My Profile" screen (Figma node 331:5267): avatar header
/// with account stats, over a menu list reusing the same Saved Addresses /
/// Payment Methods / Privacy & Security / Help & Support screens as the
/// customer flow.
class ShopperProfileScreen extends StatelessWidget {
  const ShopperProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final profile = ShopperProfileMockData.profile;

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
                            child: ClipOval(child: Image.asset(AppAssets.hostAvatar, fit: BoxFit.cover)),
                          ),
                          SizedBox(width: responsive.spacing(12)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(profile.name, style: AppTextStyles.titleSmall.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                              Text(profile.email, style: AppTextStyles.bodySmall.copyWith(color: const Color(0xFFE0E0E0))),
                              SizedBox(height: responsive.spacing(4)),
                              Row(
                                children: [
                                  SvgPicture.asset(AppAssets.starRating, width: responsive.iconSize(12), height: responsive.iconSize(12), colorFilter: const ColorFilter.mode(AppColors.ratingStar, BlendMode.srcIn)),
                                  SizedBox(width: responsive.spacing(4)),
                                  Text(
                                    '${profile.customerRating} ${AppStrings.shopperCustomerRating}',
                                    style: AppTextStyles.bodySmall.copyWith(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 10.2),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () => context.push(AppRoutes.shopperEditProfile),
                        borderRadius: BorderRadius.circular(responsive.radius(8)),
                        child: Container(
                          padding: responsive.padding(horizontal: 11, vertical: 6),
                          decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(responsive.radius(8))),
                          child: Text(AppStrings.hostEdit, style: AppTextStyles.labelSmall.copyWith(color: AppColors.primary)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: responsive.spacing(24)),
                  Container(
                    width: double.infinity,
                    padding: responsive.padding(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(responsive.radius(8)),
                      boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: responsive.spacing(4), offset: Offset(0, responsive.spacing(2)))],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _ProfileStat(icon: Icons.receipt_long_rounded, value: '${profile.orders}', label: AppStrings.shopperOrders),
                        Container(width: 1, height: responsive.size(70), color: AppColors.divider),
                        _ProfileStat(icon: Icons.favorite_border_rounded, value: '${profile.favorites}', label: AppStrings.shopperFavorites),
                        Container(width: 1, height: responsive.size(70), color: AppColors.divider),
                        _ProfileStat(emoji: '💰', value: '\$${profile.saved.toStringAsFixed(0)}', label: AppStrings.shopperSaved),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: responsive.padding(horizontal: 16, vertical: 16),
              child: Column(
                children: [
                  _MenuTile(icon: Icons.location_on_outlined, background: const Color(0xFFE8F5E9), label: AppStrings.shopperSavedAddresses, onTap: () => context.push(AppRoutes.addresses)),
                  SizedBox(height: responsive.spacing(12)),
                  _MenuTile(icon: Icons.credit_card_rounded, background: const Color(0xFFE3F2FD), label: AppStrings.paymentMethods, onTap: () => context.push(AppRoutes.paymentMethods)),
                  SizedBox(height: responsive.spacing(12)),
                  _MenuTile(icon: Icons.notifications_none_rounded, background: const Color(0xFFFFF8E1), label: AppStrings.notifications, onTap: () => context.push(AppRoutes.shopperNotifications)),
                  SizedBox(height: responsive.spacing(12)),
                  _MenuTile(icon: Icons.privacy_tip_outlined, background: const Color(0xFFF3E5F5), label: AppStrings.privacySecurity, onTap: () => context.push(AppRoutes.privacySecurity)),
                  SizedBox(height: responsive.spacing(12)),
                  _MenuTile(icon: Icons.help_outline_rounded, background: const Color(0xFFF5F5F5), label: AppStrings.helpSupport, onTap: () => context.push(AppRoutes.helpSupport)),
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
                          Icon(Icons.logout_rounded, size: responsive.iconSize(16), color: AppColors.error),
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

class _ProfileStat extends StatelessWidget {
  const _ProfileStat({this.icon, this.emoji, required this.value, required this.label});

  final IconData? icon;
  final String? emoji;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Column(
      children: [
        if (icon != null)
          Icon(icon, size: responsive.iconSize(18), color: AppColors.textPrimary)
        else
          Text(emoji!, style: TextStyle(fontSize: responsive.fontSize(18))),
        Text(value, style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold, fontSize: 20, height: 28 / 20)),
        Text(label, style: AppTextStyles.bodySmall),
      ],
    );
  }
}

class _MenuTile extends StatelessWidget {
  const _MenuTile({required this.icon, required this.background, required this.label, required this.onTap});

  final IconData icon;
  final Color background;
  final String label;
  final VoidCallback onTap;

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
                  child: Icon(icon, size: responsive.iconSize(18), color: AppColors.textPrimary),
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
