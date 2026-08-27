import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../utils/responsive_helper.dart';

/// A bold label over a medium-weight value, 12px each, 6px apart — the
/// read-only field pattern used across the Host "Personal Information"
/// and "Business Details" cards.
class InfoField extends StatelessWidget {
  const InfoField({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.bold)),
        SizedBox(height: responsive.spacing(6)),
        Text(value, style: AppTextStyles.bodySmall.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w500)),
      ],
    );
  }
}
