import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive_helper.dart';

class ProfileMenuTile extends StatelessWidget {
  const ProfileMenuTile({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.iconColor,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(responsive.radius(12)),
      child: Padding(
        padding: responsive.padding(vertical: 12),
        child: Row(
          children: [
            Container(
              width: responsive.size(38),
              height: responsive.size(38),
              decoration: BoxDecoration(
                color: (iconColor ?? AppColors.primary).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: responsive.iconSize(18), color: iconColor ?? AppColors.primary),
            ),
            SizedBox(width: responsive.spacing(14)),
            Expanded(
              child: Text(
                label,
                style: TextStyle(fontSize: responsive.fontSize(14), fontWeight: FontWeight.w600),
              ),
            ),
            Icon(Icons.chevron_right_rounded, size: responsive.iconSize(20), color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}
