import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../utils/responsive_helper.dart';

/// A pill-track/circle-thumb switch matching Figma's toggle (44x24 track,
/// 16px thumb) — Material's [Switch] doesn't reproduce this shape. Shared
/// by the Host and Shopper notification-preferences screens.
class PillToggleSwitch extends StatelessWidget {
  const PillToggleSwitch({super.key, required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: responsive.size(44),
        height: responsive.size(24),
        padding: responsive.padding(all: 4),
        decoration: BoxDecoration(
          color: value ? AppColors.primary : const Color(0xFFE0E0E0),
          borderRadius: BorderRadius.circular(responsive.radius(9999)),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 150),
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: responsive.size(16),
            height: responsive.size(16),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: const Color(0x33000000), blurRadius: responsive.spacing(4), offset: Offset(0, responsive.spacing(1)))],
            ),
          ),
        ),
      ),
    );
  }
}
