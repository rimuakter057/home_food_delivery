import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../state/shopper_order_mock_data.dart';
import '../state/shopper_order_models.dart';

/// The Shopper "My Orders" list (Figma node 234:10626): a Pending /
/// Completed / Rejected tab switcher over per-order summary cards.
class ShopperOrdersScreen extends StatefulWidget {
  const ShopperOrdersScreen({super.key});

  @override
  State<ShopperOrdersScreen> createState() => _ShopperOrdersScreenState();
}

class _ShopperOrdersScreenState extends State<ShopperOrdersScreen> {
  ShopperOrderStatus _status = ShopperOrderStatus.pending;

  static const _tabs = [
    (status: ShopperOrderStatus.pending, label: AppStrings.shopperTabPending),
    (status: ShopperOrderStatus.completed, label: AppStrings.shopperTabCompleted),
    (status: ShopperOrderStatus.rejected, label: AppStrings.shopperTabRejected),
  ];

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final orders = ShopperOrderMockData.byStatus(_status);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: responsive.padding(horizontal: 16, vertical: 8),
              child: Text(AppStrings.shopperMyOrders, style: AppTextStyles.titleLarge, textAlign: TextAlign.center),
            ),
            Padding(
              padding: responsive.padding(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: _tabs.map((tab) {
                  final isActive = tab.status == _status;
                  final count = ShopperOrderMockData.byStatus(tab.status).length;
                  return Padding(
                    padding: EdgeInsets.only(right: responsive.spacing(38)),
                    child: InkWell(
                      onTap: () => setState(() => _status = tab.status),
                      child: Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                tab.label,
                                style: AppTextStyles.labelSmall.copyWith(
                                  color: isActive ? AppColors.primary : AppColors.textSecondary,
                                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: responsive.spacing(8)),
                              Container(
                                width: responsive.size(20),
                                padding: responsive.padding(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: isActive ? const Color(0xFFE8F5E9) : const Color(0xFFF5F5F5),
                                  borderRadius: BorderRadius.circular(responsive.radius(10)),
                                ),
                                child: Text(
                                  '$count',
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.labelSmall.copyWith(
                                    color: isActive ? AppColors.primary : const Color(0xFF848484),
                                    fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: responsive.spacing(8)),
                          Container(height: 2, width: responsive.size(60), color: isActive ? AppColors.primary : Colors.transparent),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            Divider(color: AppColors.textPlaceholder, height: 1),
            Expanded(
              child: ListView.separated(
                padding: responsive.padding(horizontal: 16, vertical: 16),
                itemCount: orders.length,
                separatorBuilder: (_, __) => SizedBox(height: responsive.spacing(12)),
                itemBuilder: (context, index) => _OrderCard(
                  order: orders[index],
                  onTap: () => context.push(AppRoutes.shopperOrderTrackingPath(orders[index].id)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  const _OrderCard({required this.order, required this.onTap});

  final ShopperOrderModel order;
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
                      child: Center(child: Text(order.emoji, style: TextStyle(fontSize: responsive.fontSize(17)))),
                    ),
                    SizedBox(width: responsive.spacing(12)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(order.storeName, style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold)),
                        Text('${order.itemCount} items   ·  ${order.time}', style: AppTextStyles.bodySmall),
                      ],
                    ),
                  ],
                ),
                if (order.status == ShopperOrderStatus.pending)
                  Text('\$${order.amount.toStringAsFixed(2)}', style: AppTextStyles.titleSmall.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 16, height: 24 / 16))
                else
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: responsive.padding(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: order.status == ShopperOrderStatus.completed ? const Color(0xFFE8F5E9) : const Color(0xFFFFEBEE),
                          borderRadius: BorderRadius.circular(responsive.radius(4)),
                        ),
                        child: Text(
                          order.status == ShopperOrderStatus.completed ? AppStrings.shopperCompleted : AppStrings.shopperRejected,
                          style: AppTextStyles.labelSmall.copyWith(
                            color: order.status == ShopperOrderStatus.completed ? AppColors.primary : AppColors.error,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
            if (order.status == ShopperOrderStatus.pending) ...[
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.close_rounded, size: responsive.iconSize(14), color: AppColors.textSecondary),
                          SizedBox(width: responsive.spacing(6)),
                          Text(AppStrings.shopperDecline, style: AppTextStyles.labelSmall.copyWith(color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
                        ],
                      ),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.check_rounded, size: responsive.iconSize(14), color: Colors.white),
                          SizedBox(width: responsive.spacing(6)),
                          Text(AppStrings.shopperAccept, style: AppTextStyles.labelSmall.copyWith(color: Colors.white, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
