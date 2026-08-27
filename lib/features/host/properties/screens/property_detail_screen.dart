import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../state/property_mock_data.dart';
import '../state/property_models.dart';

/// The Host property detail screen (Figma node 517:5785): hero photo,
/// property code with copy/share, delivery rules, and recent orders.
class PropertyDetailScreen extends StatelessWidget {
  const PropertyDetailScreen({super.key, required this.propertyId});

  final String propertyId;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final property = PropertyMockData.byId(propertyId);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: responsive.padding(horizontal: 16, vertical: 8),
          children: [
            InkWell(
              onTap: () => context.pop(),
              borderRadius: BorderRadius.circular(responsive.radius(12)),
              child: SvgPicture.asset(
                AppAssets.chevronBack,
                width: responsive.iconSize(24),
                height: responsive.iconSize(24),
                colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
              ),
            ),
            SizedBox(height: responsive.spacing(16)),
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(responsive.radius(8)),
                topRight: Radius.circular(responsive.radius(8)),
              ),
              child: Stack(
                children: [
                  Image.asset(property.image, width: double.infinity, height: responsive.size(118), fit: BoxFit.cover),
                  Positioned(
                    right: responsive.spacing(12),
                    top: responsive.spacing(12),
                    child: Container(
                      width: responsive.size(26),
                      height: responsive.size(26),
                      decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.36), borderRadius: BorderRadius.circular(responsive.radius(4))),
                      child: Center(
                        child: SvgPicture.asset(AppAssets.hostEditPencil, width: responsive.iconSize(14), height: responsive.iconSize(14)),
                      ),
                    ),
                  ),
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
                              child: Text(property.type, style: AppTextStyles.labelSmall.copyWith(color: Colors.white)),
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
                      SvgPicture.asset(AppAssets.locationPinSmall, width: responsive.iconSize(16), height: responsive.iconSize(16), colorFilter: const ColorFilter.mode(AppColors.textSecondary, BlendMode.srcIn)),
                      SizedBox(width: responsive.spacing(12)),
                      Expanded(child: Text(property.address, style: AppTextStyles.bodySmall)),
                    ],
                  ),
                  SizedBox(height: responsive.spacing(12)),
                  Container(
                    width: double.infinity,
                    padding: responsive.padding(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(border: Border.all(color: AppColors.border, width: 0.5), borderRadius: BorderRadius.circular(responsive.radius(8))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
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
                            Row(
                              children: [
                                SvgPicture.asset(AppAssets.hostCopyIcon, width: responsive.iconSize(20), height: responsive.iconSize(20)),
                                SizedBox(width: responsive.spacing(4)),
                                SvgPicture.asset(AppAssets.hostShareIcon, width: responsive.iconSize(20), height: responsive.iconSize(20)),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: responsive.spacing(12)),
                        Container(
                          width: double.infinity,
                          padding: responsive.padding(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(color: const Color(0xFFF5F5F5), borderRadius: BorderRadius.circular(responsive.radius(8))),
                          child: Text(AppStrings.hostShareCodeNote, style: AppTextStyles.bodySmall),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: responsive.spacing(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppStrings.hostDeliveryRules, style: AppTextStyles.titleSmall),
                Text(AppStrings.hostViewAll, style: AppTextStyles.labelSmall.copyWith(color: AppColors.tealText, fontWeight: FontWeight.w500)),
              ],
            ),
            SizedBox(height: responsive.spacing(12)),
            Container(
              width: double.infinity,
              padding: responsive.padding(all: 12),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(responsive.radius(8)),
                boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: responsive.spacing(4), offset: Offset(0, responsive.spacing(2)))],
              ),
              child: Column(
                children: [
                  _RuleTile(
                    icon: AppAssets.hostCalendarIcon,
                    background: const Color(0xFFE3F2FD),
                    title: AppStrings.hostGuestStayDuration,
                    subtitle: property.guestStayDuration,
                  ),
                  SizedBox(height: responsive.spacing(12)),
                  _RuleTile(
                    icon: AppAssets.hostClockIcon,
                    background: const Color(0xFFFFF3E0),
                    title: AppStrings.hostDeliveryWindow,
                    subtitle: property.deliveryWindow,
                  ),
                ],
              ),
            ),
            SizedBox(height: responsive.spacing(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppStrings.hostRecentOrders, style: AppTextStyles.titleSmall),
                Text(AppStrings.hostViewAll, style: AppTextStyles.labelSmall.copyWith(color: AppColors.tealText, fontWeight: FontWeight.w500)),
              ],
            ),
            SizedBox(height: responsive.spacing(12)),
            ...property.recentOrders.map(
              (order) => Padding(
                padding: EdgeInsets.only(bottom: responsive.spacing(12)),
                child: _RecentOrderTile(order: order),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RuleTile extends StatelessWidget {
  const _RuleTile({required this.icon, required this.background, required this.title, required this.subtitle});

  final String icon;
  final Color background;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Row(
      children: [
        Container(
          width: responsive.size(40),
          height: responsive.size(40),
          decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(responsive.radius(8))),
          child: Center(child: SvgPicture.asset(icon, width: responsive.iconSize(20), height: responsive.iconSize(20))),
        ),
        SizedBox(width: responsive.spacing(12)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.w600)),
              Text(subtitle, style: AppTextStyles.bodySmall),
            ],
          ),
        ),
        SvgPicture.asset(AppAssets.chevronRightSmall, width: responsive.iconSize(20), height: responsive.iconSize(20)),
      ],
    );
  }
}

class _RecentOrderTile extends StatelessWidget {
  const _RecentOrderTile({required this.order});

  final RecentOrderModel order;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Container(
      width: double.infinity,
      padding: responsive.padding(all: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(responsive.radius(8)),
        boxShadow: [BoxShadow(color: const Color(0x0F000000), blurRadius: responsive.spacing(8), offset: Offset(0, responsive.spacing(2)))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(order.customerName, style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold)),
              Text('${order.orderId} • ${order.date}', style: AppTextStyles.bodySmall),
            ],
          ),
          Container(
            padding: responsive.padding(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: order.isApproved ? const Color(0xFFE8F5E9) : const Color(0xFFFFF3E0),
              borderRadius: BorderRadius.circular(responsive.radius(4)),
            ),
            child: Text(
              order.isApproved ? AppStrings.hostApproved : AppStrings.hostPending,
              style: AppTextStyles.labelSmall.copyWith(color: order.isApproved ? AppColors.primary : AppColors.ratingStar, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
