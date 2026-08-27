import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../utils/responsive_helper.dart';
import 'app_button.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Center(
      child: Padding(
        padding: responsive.padding(all: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: responsive.size(88),
              height: responsive.size(88),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: responsive.iconSize(40), color: AppColors.primary),
            ),
            SizedBox(height: responsive.spacing(20)),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: responsive.fontSize(17),
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: responsive.spacing(8)),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: responsive.fontSize(13), color: AppColors.textSecondary),
            ),
            if (actionLabel != null && onAction != null) ...[
              SizedBox(height: responsive.spacing(24)),
              SizedBox(
                width: responsive.size(180),
                child: AppButton(label: actionLabel!, onPressed: onAction),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
