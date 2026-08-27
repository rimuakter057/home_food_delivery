import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../state/shopper_earnings_mock_data.dart';
import '../state/shopper_earnings_models.dart';

/// The Shopper "Earnings" dashboard (Figma node 234:12711, with 244:14142
/// "Today" and 244:14644 "Monthly" as tab-state variants of the same
/// screen): a period filter over a bar-chart breakdown, quick stats, and
/// payout history.
class ShopperEarningsScreen extends StatefulWidget {
  const ShopperEarningsScreen({super.key});

  @override
  State<ShopperEarningsScreen> createState() => _ShopperEarningsScreenState();
}

class _ShopperEarningsScreenState extends State<ShopperEarningsScreen> {
  ShopperEarningsPeriod _period = ShopperEarningsPeriod.thisWeek;

  static const _periods = [
    (period: ShopperEarningsPeriod.today, label: AppStrings.shopperTabToday),
    (period: ShopperEarningsPeriod.thisWeek, label: AppStrings.shopperTabThisWeek),
    (period: ShopperEarningsPeriod.monthly, label: AppStrings.shopperTabMonthly),
  ];

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final summary = ShopperEarningsMockData.summaries[_period]!;

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
                      Text(AppStrings.shopperEarnings, style: AppTextStyles.titleSmall.copyWith(color: Colors.white, fontSize: 20, height: 28 / 20)),
                      InkWell(
                        onTap: () => context.push(AppRoutes.shopperWithdraw),
                        borderRadius: BorderRadius.circular(responsive.radius(8)),
                        child: Container(
                          padding: responsive.padding(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(responsive.radius(8))),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(AppAssets.shopperWithdrawIcon, width: responsive.iconSize(14), height: responsive.iconSize(14)),
                              SizedBox(width: responsive.spacing(4)),
                              Text(AppStrings.shopperWithdraw, style: AppTextStyles.bodyMedium.copyWith(color: Colors.white, fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: responsive.spacing(12)),
                  Container(
                    width: double.infinity,
                    padding: responsive.padding(all: 12),
                    decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(responsive.radius(8))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_periods.firstWhere((tab) => tab.period == _period).label, style: AppTextStyles.fieldLabel.copyWith(fontWeight: FontWeight.w500)),
                        Text('\$${summary.amount.toStringAsFixed(2)}', style: TextStyle(fontFamily: AppTextStyles.fieldLabel.fontFamily, fontSize: responsive.fontSize(36), fontWeight: FontWeight.w500, color: AppColors.textPrimary, height: 48 / 36)),
                        SizedBox(height: responsive.spacing(8)),
                        Text(
                          ' ${summary.deliveries} deliveries · Avg \$${summary.avgPerDelivery.toStringAsFixed(2)} /delivery',
                          style: AppTextStyles.bodySmall.copyWith(color: AppColors.textPrimary),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: responsive.spacing(24)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppStrings.shopperAvailableToWithdraw, style: AppTextStyles.bodySmall.copyWith(color: Colors.white.withValues(alpha: 0.8))),
                      Text('\$${ShopperEarningsMockData.availableBalance.toStringAsFixed(2)}', style: AppTextStyles.bodySmall.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: responsive.spacing(12)),
                  Container(
                    width: double.infinity,
                    padding: responsive.padding(all: 12),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(responsive.radius(12)),
                      boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: responsive.spacing(4), offset: Offset(0, responsive.spacing(2)))],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: _periods.map((tab) {
                        final isActive = tab.period == _period;
                        return InkWell(
                          onTap: () => setState(() => _period = tab.period),
                          borderRadius: BorderRadius.circular(responsive.radius(8)),
                          child: Container(
                            padding: responsive.padding(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: isActive ? AppColors.primary : Colors.transparent,
                              borderRadius: BorderRadius.circular(responsive.radius(8)),
                            ),
                            child: Text(
                              tab.label,
                              style: AppTextStyles.buttonLabel.copyWith(color: isActive ? Colors.white : AppColors.primary, fontSize: 12, height: 22 / 12),
                            ),
                          ),
                        );
                      }).toList(),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppStrings.shopperBreakdown, style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold)),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(AppAssets.shopperBreakdownFilterIcon, width: responsive.iconSize(14), height: responsive.iconSize(14)),
                          SizedBox(width: responsive.spacing(6)),
                          Text(_periods.firstWhere((tab) => tab.period == _period).label, style: AppTextStyles.bodySmall),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: responsive.spacing(12)),
                  Container(
                    width: double.infinity,
                    height: responsive.size(151),
                    padding: responsive.padding(horizontal: 8, vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(responsive.radius(8)),
                      boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: responsive.spacing(4), offset: Offset(0, responsive.spacing(2)))],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: summary.bars.map((bar) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: responsive.size(28),
                              height: responsive.size(80) * bar.heightFraction,
                              decoration: BoxDecoration(
                                color: bar.highlighted ? const Color(0xFF1565C0) : const Color(0xFFBBDEFB),
                                borderRadius: BorderRadius.vertical(top: Radius.circular(responsive.radius(8))),
                              ),
                            ),
                            SizedBox(height: responsive.spacing(6)),
                            Text(bar.label, style: TextStyle(fontFamily: AppTextStyles.bodySmall.fontFamily, fontSize: responsive.fontSize(8.5), fontWeight: FontWeight.w500, color: AppColors.textSecondary)),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: responsive.spacing(20)),
                  Row(
                    children: [
                      Expanded(child: _MiniStat(icon: AppAssets.shopperPerOrderIcon, value: '\$${summary.avgPerDelivery.toStringAsFixed(2)}', label: AppStrings.shopperPerOrder)),
                      SizedBox(width: responsive.spacing(14)),
                      Expanded(child: _MiniStat(icon: AppAssets.shopperOrdersIcon, value: '${summary.deliveries}', label: AppStrings.shopperOrders)),
                      SizedBox(width: responsive.spacing(14)),
                      Expanded(child: _MiniStat(icon: AppAssets.shopperOnlineIcon, value: '${ShopperEarningsMockData.onlineHours}h', label: AppStrings.shopperOnline)),
                    ],
                  ),
                  SizedBox(height: responsive.spacing(20)),
                  Text(AppStrings.shopperPayoutHistory, style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold)),
                  SizedBox(height: responsive.spacing(12)),
                  ...ShopperEarningsMockData.payoutHistory.map(
                    (payout) => Padding(
                      padding: EdgeInsets.only(bottom: responsive.spacing(12)),
                      child: _PayoutCard(payout: payout),
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

class _MiniStat extends StatelessWidget {
  const _MiniStat({required this.icon, required this.value, required this.label});

  final String icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Container(
      height: responsive.size(80),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(responsive.radius(8)),
        boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: responsive.spacing(4), offset: Offset(0, responsive.spacing(2)))],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(icon, width: responsive.iconSize(16), height: responsive.iconSize(16)),
          SizedBox(height: responsive.spacing(6)),
          Text(value, style: AppTextStyles.titleSmall.copyWith(color: AppColors.textSecondary, fontWeight: FontWeight.bold)),
          Text(label, style: AppTextStyles.bodySmall),
        ],
      ),
    );
  }
}

class _PayoutCard extends StatelessWidget {
  const _PayoutCard({required this.payout});

  final ShopperPayoutModel payout;

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
                decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(responsive.radius(8))),
                child: Center(child: SvgPicture.asset(AppAssets.shopperPayoutIcon, width: responsive.iconSize(18), height: responsive.iconSize(18))),
              ),
              SizedBox(width: responsive.spacing(12)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppStrings.shopperWeeklyPayout, style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold)),
                  Text('${payout.date}  ·  ${payout.deliveries} deliveries', style: AppTextStyles.bodySmall),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('\$${payout.amount.toStringAsFixed(2)}', style: AppTextStyles.titleSmall.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold)),
              SizedBox(height: responsive.spacing(4)),
              Container(
                padding: responsive.padding(horizontal: 6, vertical: 1),
                decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(responsive.radius(8))),
                child: Text(
                  payout.isPaid ? AppStrings.shopperPaid : '',
                  style: TextStyle(fontFamily: AppTextStyles.bodySmall.fontFamily, fontSize: responsive.fontSize(8.5), fontWeight: FontWeight.w500, color: AppColors.primary),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
