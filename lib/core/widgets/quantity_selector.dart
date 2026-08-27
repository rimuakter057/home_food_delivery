import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../utils/responsive_helper.dart';

class QuantitySelector extends StatelessWidget {
  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
    this.minQuantity = 1,
  });

  final int quantity;
  final int minQuantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Container(
      padding: responsive.padding(horizontal: 4, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(responsive.radius(10)),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _QuantityIconButton(
            icon: Icons.remove_rounded,
            onTap: quantity > minQuantity ? onDecrement : null,
          ),
          SizedBox(
            width: responsive.size(28),
            child: Text(
              '$quantity',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: responsive.fontSize(14), fontWeight: FontWeight.w700),
            ),
          ),
          _QuantityIconButton(icon: Icons.add_rounded, onTap: onIncrement),
        ],
      ),
    );
  }
}

class _QuantityIconButton extends StatelessWidget {
  const _QuantityIconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final isEnabled = onTap != null;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(responsive.radius(8)),
      child: Container(
        padding: responsive.padding(all: 6),
        child: Icon(
          icon,
          size: responsive.iconSize(16),
          color: isEnabled ? AppColors.primary : AppColors.textSecondary.withValues(alpha: 0.4),
        ),
      ),
    );
  }
}
