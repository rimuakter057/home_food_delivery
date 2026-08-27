import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/widgets/app_card.dart';
import '../state/order_models.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.order, required this.onTap});

  final OrderModel order;
  final VoidCallback onTap;

  String get _statusLabel {
    switch (order.status) {
      case OrderStatus.placed:
        return AppStrings.statusPlaced;
      case OrderStatus.confirmed:
        return AppStrings.statusConfirmed;
      case OrderStatus.preparing:
        return AppStrings.statusPreparing;
      case OrderStatus.onTheWay:
        return AppStrings.statusOnTheWay;
      case OrderStatus.delivered:
        return AppStrings.statusDelivered;
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final isDelivered = order.status == OrderStatus.delivered;
    return AppCard(
      onTap: onTap,
      margin: EdgeInsets.only(bottom: responsive.spacing(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(order.kitchenName, style: AppTextStyles.titleSmall),
              Container(
                padding: responsive.padding(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: (isDelivered ? AppColors.success : AppColors.primary).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(responsive.radius(8)),
                ),
                child: Text(
                  _statusLabel,
                  style: TextStyle(
                    fontSize: responsive.fontSize(10),
                    fontWeight: FontWeight.w700,
                    color: isDelivered ? AppColors.success : AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: responsive.spacing(6)),
          Text(
            '${AppStrings.orderIdLabel}: ${order.id} · ${order.totalItemCount} items',
            style: TextStyle(fontSize: responsive.fontSize(11), color: AppColors.textSecondary),
          ),
          SizedBox(height: responsive.spacing(10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${AppStrings.currencySymbol}${order.total.toStringAsFixed(2)}',
                style: TextStyle(fontSize: responsive.fontSize(14), fontWeight: FontWeight.w800, color: AppColors.primary),
              ),
              Text(
                AppStrings.viewDetails,
                style: TextStyle(fontSize: responsive.fontSize(12), fontWeight: FontWeight.w600, color: AppColors.primary),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
