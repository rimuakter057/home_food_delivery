import 'package:flutter/material.dart';
import '../constants/app_strings.dart';
import '../theme/app_text_styles.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title, this.onSeeAll});

  final String title;
  final VoidCallback? onSeeAll;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold)),
        if (onSeeAll != null)
          GestureDetector(
            onTap: onSeeAll,
            child: Text(AppStrings.seeAll, style: AppTextStyles.labelSmall),
          ),
      ],
    );
  }
}
