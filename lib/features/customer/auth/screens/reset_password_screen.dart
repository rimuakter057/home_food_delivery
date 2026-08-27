import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../state/auth_validators.dart';
import '../widgets/auth_hero_header.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (!_formKey.currentState!.validate()) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text(AppStrings.resetPasswordSuccessMessage)),
    );
    context.go(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AuthHeroHeader(
              title: AppStrings.resetPasswordTitle,
              subtitle: AppStrings.resetPasswordSubtitle,
            ),
            Padding(
              padding: responsive.padding(horizontal: 24).copyWith(top: responsive.spacing(45)),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppTextField(
                      label: AppStrings.password,
                      hint: AppStrings.enterPassword,
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      validator: AuthValidators.password,
                      suffixIcon: IconButton(
                        icon: _obscurePassword
                            ? SvgPicture.asset(
                                AppAssets.eyeToggle,
                                width: 18,
                                height: 18,
                                colorFilter: const ColorFilter.mode(AppColors.textSecondary, BlendMode.srcIn),
                              )
                            : const Icon(Icons.visibility_off_outlined),
                        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                      ),
                    ),
                    SizedBox(height: responsive.spacing(12)),
                    AppTextField(
                      label: AppStrings.confirmPassword,
                      hint: AppStrings.enterConfirmPassword,
                      controller: _confirmPasswordController,
                      obscureText: _obscurePassword,
                      validator: AuthValidators.confirmPassword(() => _passwordController.text),
                    ),
                    SizedBox(height: responsive.spacing(28)),
                    AppButton(label: AppStrings.submit, large: true, onPressed: _handleSubmit),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
