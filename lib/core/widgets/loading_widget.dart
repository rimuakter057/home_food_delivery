import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../utils/responsive_helper.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, this.message = AppStrings.loading});

  final String message;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: responsive.size(32),
            height: responsive.size(32),
            child: const CircularProgressIndicator(strokeWidth: 2.5, color: AppColors.primary),
          ),
          SizedBox(height: responsive.spacing(12)),
          Text(
            message,
            style: TextStyle(fontSize: responsive.fontSize(13), color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}
