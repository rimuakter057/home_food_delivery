import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../state/cart_state.dart';

class CartSummary extends StatelessWidget {
  const CartSummary({super.key, required this.cart});

  final CartState cart;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.orderSummary, style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold)),
        SizedBox(height: responsive.spacing(12)),
        _SummaryRow(label: AppStrings.subtotal, value: cart.subtotal),
        SizedBox(height: responsive.spacing(8)),
        _SummaryRow(label: AppStrings.deliveryFee, value: CartState.deliveryFee),
        SizedBox(height: responsive.spacing(8)),
        _SummaryRow(label: AppStrings.tax, value: cart.taxAmount),
        Padding(
          padding: EdgeInsets.symmetric(vertical: responsive.spacing(12)),
          child: const Divider(),
        ),
        _SummaryRow(label: AppStrings.totalAmount, value: cart.total, isTotal: true),
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value, this.isTotal = false});

  final String label;
  final double value;
  final bool isTotal;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final style = TextStyle(
      fontSize: responsive.fontSize(isTotal ? 15 : 13),
      fontWeight: isTotal ? FontWeight.w800 : FontWeight.w500,
      color: isTotal ? AppColors.textPrimary : AppColors.textSecondary,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        Text('${AppStrings.currencySymbol}${value.toStringAsFixed(2)}', style: style),
      ],
    );
  }
}
