import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/widgets/app_button.dart';
import '../../navigation/state/navigation_state.dart';
import '../state/orders_state.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key, required this.orderId});

  final String orderId;

  void _backToHome(BuildContext context) {
    context.read<NavigationState>().setIndex(0);
    context.go(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final order = context.watch<OrdersState>().orderById(orderId);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: responsive.padding(all: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: responsive.size(112),
                height: responsive.size(112),
                decoration: const BoxDecoration(color: Color(0xFFE8F5E9), shape: BoxShape.circle),
                child: const Center(child: Text('🎉', style: TextStyle(fontSize: 48))),
              ),
              SizedBox(height: responsive.spacing(20)),
              Text(AppStrings.orderPlacedTitle, style: AppTextStyles.headlineLarge.copyWith(fontSize: 24)),
              SizedBox(height: responsive.spacing(6)),
              Text('Your order has been confirmed', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary)),
              SizedBox(height: responsive.spacing(20)),
              Container(
                padding: responsive.padding(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(responsive.radius(20))),
                child: RichText(
                  text: TextSpan(
                    style: AppTextStyles.bodyMedium,
                    children: [
                      const TextSpan(text: 'Order #', style: TextStyle(color: AppColors.textSecondary)),
                      TextSpan(text: order.id, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                    ],
                  ),
                ),
              ),
              SizedBox(height: responsive.spacing(24)),
              Row(
                children: [
                  Expanded(
                    child: _InfoTile(
                      icon: Icons.access_time_rounded,
                      label: 'Estimated Time',
                      value: '${order.estimatedDeliveryMinutes} min',
                    ),
                  ),
                  SizedBox(width: responsive.spacing(12)),
                  const Expanded(
                    child: _InfoTile(icon: Icons.receipt_long_rounded, label: 'Status', value: 'Preparing'),
                  ),
                ],
              ),
              SizedBox(height: responsive.spacing(16)),
              Container(
                width: double.infinity,
                padding: responsive.padding(all: 12),
                decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(responsive.radius(8))),
                child: Row(
                  children: [
                    Container(
                      width: responsive.size(40),
                      height: responsive.size(40),
                      decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(responsive.radius(8))),
                      child: const Center(child: Text('🌿', style: TextStyle(fontSize: 20))),
                    ),
                    SizedBox(width: responsive.spacing(12)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(order.kitchenName, style: AppTextStyles.titleSmall),
                          Text('Delivering to your address', style: AppTextStyles.bodySmall),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: responsive.spacing(24)),
              AppButton(
                label: 'Track My Order',
                onPressed: () => context.push(AppRoutes.orderTrackingPath(orderId)),
              ),
              SizedBox(height: responsive.spacing(12)),
              TextButton(
                onPressed: () => _backToHome(context),
                child: Text(AppStrings.backToHome, style: AppTextStyles.labelSmall),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({required this.icon, required this.label, required this.value});

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Container(
      padding: responsive.padding(all: 16),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(responsive.radius(8))),
      child: Column(
        children: [
          Icon(icon, color: AppColors.primary, size: responsive.iconSize(22)),
          SizedBox(height: responsive.spacing(6)),
          Text(label, style: AppTextStyles.bodySmall),
          SizedBox(height: responsive.spacing(4)),
          Text(value, style: AppTextStyles.titleSmall),
        ],
      ),
    );
  }
}
