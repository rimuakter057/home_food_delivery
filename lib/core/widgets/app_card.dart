import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../utils/responsive_helper.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.margin,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final borderRadius = BorderRadius.circular(responsive.radius(8));
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: responsive.spacing(4),
            offset: Offset(0, responsive.spacing(2)),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: borderRadius,
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius,
          child: Padding(
            padding: padding ?? responsive.padding(all: 12),
            child: child,
          ),
        ),
      ),
    );
  }
}
