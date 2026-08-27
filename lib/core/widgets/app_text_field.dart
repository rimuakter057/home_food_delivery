import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../utils/responsive_helper.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.label,
    required this.hint,
    this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.prefixIcon,
    this.prefixWidget,
    this.suffixIcon,
    this.validator,
    this.onChanged,
  });

  final String? label;
  final String hint;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  final IconData? prefixIcon;

  /// A custom leading widget (e.g. an SVG icon) — takes priority over
  /// [prefixIcon] when set.
  final Widget? prefixWidget;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(label!, style: AppTextStyles.fieldLabel),
          SizedBox(height: responsive.spacing(8)),
        ],
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          validator: validator,
          onChanged: onChanged,
          style: AppTextStyles.bodyMedium,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: prefixWidget ??
                (prefixIcon != null ? Icon(prefixIcon, size: responsive.iconSize(20), color: AppColors.textSecondary) : null),
            suffixIcon: suffixIcon,
            contentPadding: responsive.padding(horizontal: 16, vertical: 15),
          ),
        ),
      ],
    );
  }
}
