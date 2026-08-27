import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/custom_app_bar.dart';

class PrivacySecurityScreen extends StatefulWidget {
  const PrivacySecurityScreen({super.key});

  @override
  State<PrivacySecurityScreen> createState() => _PrivacySecurityScreenState();
}

class _PrivacySecurityScreenState extends State<PrivacySecurityScreen> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _updatePassword() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text(AppStrings.passwordUpdatedMessage)),
    );
    _oldPasswordController.clear();
    _newPasswordController.clear();
    _confirmPasswordController.clear();
  }

  Future<void> _confirmDelete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text(AppStrings.deleteAccount),
        content: const Text(AppStrings.deleteAccountConfirm),
        actions: [
          TextButton(onPressed: () => Navigator.of(dialogContext).pop(false), child: const Text(AppStrings.cancel)),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text(AppStrings.deleteAccount, style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
    if (confirmed == true && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.deleteAccount)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(title: AppStrings.privacySecurity),
      body: SafeArea(
        child: ListView(
          padding: responsive.padding(all: 16),
          children: [
            Text(AppStrings.securityLabel, style: AppTextStyles.bodySmall.copyWith(fontSize: 14, fontWeight: FontWeight.w600)),
            SizedBox(height: responsive.spacing(12)),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: responsive.size(40),
                        height: responsive.size(40),
                        decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(responsive.radius(8))),
                        child: const Icon(Icons.lock_outline_rounded, color: AppColors.primary, size: 18),
                      ),
                      SizedBox(width: responsive.spacing(12)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppStrings.changePassword, style: AppTextStyles.titleSmall),
                            Text(AppStrings.lastChangedSubtitle, style: AppTextStyles.bodySmall),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: responsive.spacing(20)),
                  AppTextField(
                    label: AppStrings.oldPassword,
                    hint: AppStrings.enterPassword,
                    controller: _oldPasswordController,
                    obscureText: true,
                  ),
                  SizedBox(height: responsive.spacing(12)),
                  AppTextField(
                    label: AppStrings.password,
                    hint: AppStrings.enterPassword,
                    controller: _newPasswordController,
                    obscureText: true,
                  ),
                  SizedBox(height: responsive.spacing(12)),
                  AppTextField(
                    label: AppStrings.confirmPassword,
                    hint: AppStrings.enterConfirmPassword,
                    controller: _confirmPasswordController,
                    obscureText: true,
                  ),
                  SizedBox(height: responsive.spacing(20)),
                  AppButton(label: AppStrings.updatePassword, onPressed: _updatePassword),
                ],
              ),
            ),
            SizedBox(height: responsive.spacing(16)),
            AppCard(
              onTap: _confirmDelete,
              child: Row(
                children: [
                  Container(
                    width: responsive.size(40),
                    height: responsive.size(40),
                    decoration: BoxDecoration(color: const Color(0xFFFFEBEE), borderRadius: BorderRadius.circular(responsive.radius(8))),
                    child: const Icon(Icons.delete_outline_rounded, color: AppColors.error, size: 18),
                  ),
                  SizedBox(width: responsive.spacing(12)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppStrings.deleteAccount, style: AppTextStyles.titleSmall.copyWith(color: AppColors.error)),
                        Text(AppStrings.deleteAccountSubtitle, style: AppTextStyles.bodySmall),
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_right_rounded, size: responsive.iconSize(18), color: AppColors.textSecondary),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
