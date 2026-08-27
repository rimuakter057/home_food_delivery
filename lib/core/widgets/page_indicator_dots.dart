import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../utils/responsive_helper.dart';

class PageIndicatorDots extends StatelessWidget {
  const PageIndicatorDots({
    super.key,
    required this.count,
    required this.activeIndex,
    this.activeColor,
    this.inactiveColor,
  });

  final int count;
  final int activeIndex;
  final Color? activeColor;

  /// Figma's onboarding dots sit on a green gradient and use plain white
  /// for the inactive state (not an alpha of the active color).
  final Color? inactiveColor;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final active = activeColor ?? AppColors.primary;
    final inactive = inactiveColor ?? Colors.white;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final isActive = index == activeIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: responsive.padding(horizontal: 4),
          width: responsive.size(isActive ? 24 : 8),
          height: responsive.size(8),
          decoration: BoxDecoration(
            color: isActive ? active : inactive,
            borderRadius: BorderRadius.circular(responsive.radius(4)),
          ),
        );
      }),
    );
  }
}
