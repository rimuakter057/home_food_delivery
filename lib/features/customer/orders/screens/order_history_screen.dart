import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../state/order_models.dart';
import '../state/orders_state.dart';
import '../widgets/order_card.dart';

enum _OrderTab { pending, completed, cancelled }

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  _OrderTab _tab = _OrderTab.pending;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final allOrders = context.watch<OrdersState>().orders;
    final pending = allOrders.where((o) => o.status != OrderStatus.delivered).toList();
    final completed = allOrders.where((o) => o.status == OrderStatus.delivered).toList();
    const cancelled = <OrderModel>[];

    final orders = switch (_tab) {
      _OrderTab.pending => pending,
      _OrderTab.completed => completed,
      _OrderTab.cancelled => cancelled,
    };

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(AppStrings.orderHistoryTitle, style: AppTextStyles.titleLarge),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: responsive.padding(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  _TabChip(
                    label: 'Pending',
                    count: pending.length,
                    isSelected: _tab == _OrderTab.pending,
                    onTap: () => setState(() => _tab = _OrderTab.pending),
                  ),
                  SizedBox(width: responsive.spacing(20)),
                  _TabChip(
                    label: 'Completed',
                    count: completed.length,
                    isSelected: _tab == _OrderTab.completed,
                    onTap: () => setState(() => _tab = _OrderTab.completed),
                  ),
                  SizedBox(width: responsive.spacing(20)),
                  _TabChip(
                    label: 'Cancelled',
                    count: cancelled.length,
                    isSelected: _tab == _OrderTab.cancelled,
                    onTap: () => setState(() => _tab = _OrderTab.cancelled),
                  ),
                ],
              ),
            ),
            Expanded(
              child: orders.isEmpty
                  ? const EmptyStateWidget(
                      icon: Icons.receipt_long_outlined,
                      title: AppStrings.emptyOrdersTitle,
                      subtitle: AppStrings.emptyOrdersSubtitle,
                    )
                  : ListView(
                      padding: responsive.padding(horizontal: 16),
                      children: orders
                          .map(
                            (order) => OrderCard(
                              order: order,
                              onTap: () => context.push(AppRoutes.orderTrackingPath(order.id)),
                            ),
                          )
                          .toList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabChip extends StatelessWidget {
  const _TabChip({required this.label, required this.count, required this.isSelected, required this.onTap});

  final String label;
  final int count;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? AppColors.primary : AppColors.textSecondary;
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Text('$label ($count)', style: AppTextStyles.bodySmall.copyWith(color: color, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
          const SizedBox(height: 6),
          Container(height: 2, width: 60, color: isSelected ? AppColors.primary : Colors.transparent),
        ],
      ),
    );
  }
}
