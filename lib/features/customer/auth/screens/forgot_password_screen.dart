import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../state/auth_validators.dart';
import '../widgets/auth_hero_header.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleContinue() {
    if (!_formKey.currentState!.validate()) return;
    context.push(AppRoutes.otpVerify);
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
              title: AppStrings.forgotPasswordTitle,
              subtitle: AppStrings.forgotPasswordSubtitle,
            ),
            Padding(
              padding: responsive.padding(horizontal: 24).copyWith(top: responsive.spacing(45)),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppTextField(
                      label: AppStrings.email,
                      hint: AppStrings.enterEmail,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: AuthValidators.email,
                    ),
                    SizedBox(height: responsive.spacing(28)),
                    AppButton(label: AppStrings.continueLabel, large: true, onPressed: _handleContinue),
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
