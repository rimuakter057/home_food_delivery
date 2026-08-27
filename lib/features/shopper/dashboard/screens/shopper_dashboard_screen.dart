import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../state/shopper_mock_data.dart';
import '../state/shopper_models.dart';

/// The Shopper dashboard (Figma nodes 184:9749 offline / 228:9587 online):
/// stats, an online/offline toggle, pending requests (once online), active
/// orders, and recent deliveries.
class ShopperDashboardScreen extends StatefulWidget {
  const ShopperDashboardScreen({super.key});

  @override
  State<ShopperDashboardScreen> createState() => _ShopperDashboardScreenState();
}

class _ShopperDashboardScreenState extends State<ShopperDashboardScreen> {
  bool _isOnline = false;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final profile = ShopperMockData.profile;
    final stats = ShopperMockData.stats;

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppStrings.shopperGoodMorning, style: AppTextStyles.bodyMedium.copyWith(color: Colors.white, fontWeight: FontWeight.w500)),
                          Text('${profile.name} 👋', style: AppTextStyles.titleSmall.copyWith(color: Colors.white)),
                        ],
                      ),
                      Row(
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                width: responsive.size(36),
                                height: responsive.size(36),
                                decoration: const BoxDecoration(color: Color(0xFFF5F5F5), shape: BoxShape.circle),
                                child: Center(
                                  child: SvgPicture.asset(AppAssets.hostBell, width: responsive.iconSize(18), height: responsive.iconSize(18)),
                                ),
                              ),
                              Positioned(
                                right: -responsive.spacing(2),
                                top: -responsive.spacing(2),
                                child: Container(
                                  padding: responsive.padding(all: 3),
                                  constraints: BoxConstraints(minWidth: responsive.size(16), minHeight: responsive.size(16)),
                                  decoration: const BoxDecoration(color: AppColors.error, shape: BoxShape.circle),
                                  child: Text(
                                    '2',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white, fontSize: responsive.fontSize(9), fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: responsive.spacing(10)),
                          Container(
                            width: responsive.size(36),
                            height: responsive.size(36),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(color: const Color(0x4D2E7D32), blurRadius: responsive.spacing(8), offset: Offset(0, responsive.spacing(2))),
                              ],
                            ),
                            child: ClipOval(child: Image.asset(AppAssets.hostAvatar, fit: BoxFit.cover)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: responsive.spacing(24)),
                  Container(
                    width: double.infinity,
                    padding: responsive.padding(all: 12),
                    decoration: BoxDecoration(
                      color: _isOnline ? Colors.white.withValues(alpha: 0.2) : const Color(0xFF262626),
                      borderRadius: BorderRadius.circular(responsive.radius(8)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _isOnline ? AppStrings.shopperYoureOnline : AppStrings.shopperYoureOffline,
                              style: AppTextStyles.titleSmall.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                            Text(AppStrings.shopperGoOnlineSubtitle, style: AppTextStyles.bodySmall.copyWith(color: Colors.white.withValues(alpha: 0.7))),
                          ],
                        ),
                        GestureDetector(
                          onTap: () => setState(() => _isOnline = !_isOnline),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            width: responsive.size(56),
                            height: responsive.size(30),
                            padding: responsive.padding(all: 3),
                            decoration: BoxDecoration(
                              color: _isOnline ? const Color(0xFF4DC954) : Colors.white.withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(responsive.radius(1000)),
                            ),
                            child: AnimatedAlign(
                              duration: const Duration(milliseconds: 150),
                              alignment: _isOnline ? Alignment.centerRight : Alignment.centerLeft,
                              child: Container(
                                width: responsive.size(24),
                                height: responsive.size(24),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [BoxShadow(color: const Color(0x4D000000), blurRadius: responsive.spacing(4), offset: Offset(0, responsive.spacing(2)))],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
                        _DashboardStat(value: '\$${stats.today.toStringAsFixed(2)}', label: AppStrings.shopperToday),
                        _StatDivider(),
                        _DashboardStat(value: '${stats.deliveries}', label: AppStrings.shopperDeliveries),
                        _StatDivider(),
                        _DashboardStat(value: stats.rating.toStringAsFixed(2), label: AppStrings.shopperRating),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: responsive.padding(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _WeekStatCard(
                          icon: AppAssets.shopperStatWeek,
                          label: AppStrings.shopperThisWeek,
                          value: '\$${stats.thisWeekEarnings.toStringAsFixed(2)}',
                          caption: stats.thisWeekChangeLabel,
                          captionColor: AppColors.primary,
                        ),
                      ),
                      SizedBox(width: responsive.spacing(12)),
                      Expanded(
                        child: _WeekStatCard(
                          icon: AppAssets.shopperStatOrders,
                          label: AppStrings.shopperTotalOrders,
                          value: stats.totalOrders.toString(),
                          caption: AppStrings.shopperAllTime,
                          captionColor: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  if (_isOnline) ...[
                    SizedBox(height: responsive.spacing(20)),
                    _SectionHeader(title: AppStrings.shopperPendingRequests),
                    SizedBox(height: responsive.spacing(12)),
                    ...ShopperMockData.pendingRequests.map(
                      (request) => Padding(
                        padding: EdgeInsets.only(bottom: responsive.spacing(12)),
                        child: _PendingRequestCard(request: request),
                      ),
                    ),
                  ],
                  SizedBox(height: responsive.spacing(20)),
                  _SectionHeader(title: AppStrings.shopperActiveOrders),
                  SizedBox(height: responsive.spacing(12)),
                  ...ShopperMockData.activeOrders.map(
                    (order) => Padding(
                      padding: EdgeInsets.only(bottom: responsive.spacing(12)),
                      child: _ActiveOrderCard(order: order),
                    ),
                  ),
                  SizedBox(height: responsive.spacing(20)),
                  _SectionHeader(title: AppStrings.shopperRecentDeliveries),
                  SizedBox(height: responsive.spacing(12)),
                  ...ShopperMockData.recentDeliveries.map(
                    (delivery) => Padding(
                      padding: EdgeInsets.only(bottom: responsive.spacing(12)),
                      child: _RecentDeliveryCard(delivery: delivery),
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

class _StatDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: context.responsive.size(70), color: AppColors.divider);
  }
}

class _DashboardStat extends StatelessWidget {
  const _DashboardStat({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold, fontSize: 16)),
        Text(label, style: AppTextStyles.bodySmall.copyWith(color: AppColors.textPrimary)),
      ],
    );
  }
}

class _WeekStatCard extends StatelessWidget {
  const _WeekStatCard({required this.icon, required this.label, required this.value, required this.caption, required this.captionColor});

  final String icon;
  final String label;
  final String value;
  final String caption;
  final Color captionColor;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Container(
      width: double.infinity,
      padding: responsive.padding(horizontal: 24, vertical: 17),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(responsive.radius(8)),
        boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: responsive.spacing(4), offset: Offset(0, responsive.spacing(2)))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(icon, width: responsive.iconSize(16), height: responsive.iconSize(16)),
              SizedBox(width: responsive.spacing(6)),
              Text(label, style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w500)),
            ],
          ),
          Text(value, style: AppTextStyles.numberLarge),
          Text(caption, style: AppTextStyles.bodySmall.copyWith(color: captionColor)),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold)),
        Text(AppStrings.shopperSeeAll, style: AppTextStyles.labelSmall.copyWith(color: AppColors.primary, fontWeight: FontWeight.w500)),
      ],
    );
  }
}

class _PendingRequestCard extends StatelessWidget {
  const _PendingRequestCard({required this.request});

  final ShopperPendingRequestModel request;

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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: responsive.size(40),
                    height: responsive.size(40),
                    decoration: BoxDecoration(color: const Color(0xFFF5F5F5), borderRadius: BorderRadius.circular(responsive.radius(8))),
                    child: Center(child: Text(request.emoji, style: TextStyle(fontSize: responsive.fontSize(17)))),
                  ),
                  SizedBox(width: responsive.spacing(12)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(request.storeName, style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold)),
                      Text('${request.itemCount} items  ·  ${request.time}', style: AppTextStyles.bodySmall),
                    ],
                  ),
                ],
              ),
              Text('\$${request.amount.toStringAsFixed(2)}', style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: responsive.spacing(10)),
          Divider(color: AppColors.divider, height: 1),
          SizedBox(height: responsive.spacing(10)),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: BorderSide.none,
                    padding: responsive.padding(horizontal: 12, vertical: 6),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(responsive.radius(8))),
                  ),
                  child: Text(AppStrings.shopperDecline, style: AppTextStyles.labelSmall.copyWith(color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: responsive.padding(horizontal: 12, vertical: 6),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(responsive.radius(8))),
                  ),
                  child: Text(AppStrings.shopperAccept, style: AppTextStyles.labelSmall.copyWith(color: Colors.white, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActiveOrderCard extends StatelessWidget {
  const _ActiveOrderCard({required this.order});

  final ShopperActiveOrderModel order;

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
          Row(
            children: [
              Container(
                width: responsive.size(40),
                height: responsive.size(40),
                decoration: BoxDecoration(color: const Color(0xFFF5F5F5), borderRadius: BorderRadius.circular(responsive.radius(8))),
                child: Center(child: Text(order.emoji, style: TextStyle(fontSize: responsive.fontSize(17)))),
              ),
              SizedBox(width: responsive.spacing(12)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(order.storeName, style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold)),
                  Text('${order.recipient}  ·  ${order.itemCount} items', style: AppTextStyles.bodySmall),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: responsive.padding(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: order.statusBackground, borderRadius: BorderRadius.circular(responsive.radius(8))),
                child: Text(order.statusLabel, style: AppTextStyles.labelSmall.copyWith(color: order.statusColor, fontWeight: FontWeight.w600)),
              ),
              SizedBox(height: responsive.spacing(4)),
              SvgPicture.asset(AppAssets.chevronRightSmall, width: responsive.iconSize(16), height: responsive.iconSize(16)),
            ],
          ),
        ],
      ),
    );
  }
}

class _RecentDeliveryCard extends StatelessWidget {
  const _RecentDeliveryCard({required this.delivery});

  final ShopperRecentDeliveryModel delivery;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Container(
      width: double.infinity,
      height: responsive.size(80),
      padding: responsive.padding(all: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(responsive.radius(8)),
        boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: responsive.spacing(4), offset: Offset(0, responsive.spacing(2)))],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(responsive.radius(8)),
            child: Image.asset(delivery.image, width: responsive.size(56), height: responsive.size(56), fit: BoxFit.cover),
          ),
          SizedBox(width: responsive.spacing(12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(delivery.storeName, style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.w600)),
                Text('${delivery.recipient}  ·  ${delivery.timeAgo}', style: AppTextStyles.bodySmall),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('+\$${delivery.amount.toStringAsFixed(2)}', style: AppTextStyles.titleSmall.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold)),
              Row(
                children: [
                  SvgPicture.asset(AppAssets.starRating, width: responsive.iconSize(10), height: responsive.iconSize(10), colorFilter: const ColorFilter.mode(AppColors.ratingStar, BlendMode.srcIn)),
                  SizedBox(width: responsive.spacing(4)),
                  Text(delivery.rating.toStringAsFixed(1), style: AppTextStyles.bodySmall.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w500)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
