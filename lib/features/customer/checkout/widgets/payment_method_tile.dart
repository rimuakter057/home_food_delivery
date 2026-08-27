import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../profile/state/profile_models.dart';

class PaymentMethodTile extends StatelessWidget {
  const PaymentMethodTile({
    super.key,
    required this.method,
    required this.isSelected,
    required this.onTap,
  });

  final PaymentMethodModel method;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: responsive.padding(all: 14),
        margin: EdgeInsets.only(bottom: responsive.spacing(10)),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE8F5E9) : AppColors.surface,
          borderRadius: BorderRadius.circular(responsive.radius(8)),
        ),
        child: Row(
          children: [
            Icon(method.icon, size: responsive.iconSize(22), color: AppColors.textPrimary),
            SizedBox(width: responsive.spacing(12)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(method.label, style: AppTextStyles.titleSmall),
                  SizedBox(height: responsive.spacing(2)),
                  Text(method.subtitle, style: AppTextStyles.bodySmall),
                ],
              ),
            ),
            Icon(
              isSelected ? Icons.radio_button_checked_rounded : Icons.radio_button_off_rounded,
              size: responsive.iconSize(20),
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
