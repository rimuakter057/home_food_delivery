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
import '../../../customer/auth/state/auth_validators.dart';
import '../../../customer/auth/widgets/auth_tab_switcher.dart';
import '../widgets/shopper_wizard_header.dart';

/// Shopper Application step 1/4 (Figma node 179:6938): the same
/// name/phone/email/password fields as [SignUpScreen], under the wizard
/// progress header instead of the plain auth hero.
class ShopperBasicInfoScreen extends StatefulWidget {
  const ShopperBasicInfoScreen({super.key});

  @override
  State<ShopperBasicInfoScreen> createState() => _ShopperBasicInfoScreenState();
}

class _ShopperBasicInfoScreenState extends State<ShopperBasicInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Widget _passwordToggle() {
    return IconButton(
      icon: SvgPicture.asset(
        AppAssets.eyeToggle,
        width: 18,
        height: 18,
        colorFilter: const ColorFilter.mode(AppColors.textSecondary, BlendMode.srcIn),
      ),
      onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
    );
  }

  void _handleContinue() {
    if (!_formKey.currentState!.validate()) return;
    context.push(AppRoutes.shopperVehicle);
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
            ShopperWizardHeader(
              step: 1,
              totalSteps: 4,
              stepLabel: AppStrings.shopperStepBasicInfo,
              onBack: () => context.go(AppRoutes.roleLanding),
              overlapping: AuthTabSwitcher(
                active: AuthTab.signUp,
                onChanged: (tab) => tab == AuthTab.signIn ? context.go(AppRoutes.shopperLogin) : null,
              ),
            ),
            Padding(
              padding: responsive.padding(horizontal: 24).copyWith(top: responsive.spacing(70)),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppTextField(
                      label: AppStrings.fullName,
                      hint: AppStrings.enterFullName,
                      controller: _nameController,
                      validator: AuthValidators.name,
                    ),
                    SizedBox(height: responsive.spacing(12)),
                    AppTextField(
                      label: AppStrings.phoneNumber,
                      hint: AppStrings.enterPhoneNumber,
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      validator: AuthValidators.phone,
                    ),
                    SizedBox(height: responsive.spacing(12)),
                    AppTextField(
                      label: AppStrings.email,
                      hint: AppStrings.enterEmail,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: AuthValidators.email,
                    ),
                    SizedBox(height: responsive.spacing(12)),
                    AppTextField(
                      label: AppStrings.password,
                      hint: AppStrings.enterPassword,
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      validator: AuthValidators.password,
                      suffixIcon: _passwordToggle(),
                    ),
                    SizedBox(height: responsive.spacing(12)),
                    AppTextField(
                      label: AppStrings.confirmPassword,
                      hint: AppStrings.enterConfirmPassword,
                      controller: _confirmPasswordController,
                      obscureText: _obscurePassword,
                      validator: AuthValidators.confirmPassword(() => _passwordController.text),
                      suffixIcon: _passwordToggle(),
                    ),
                    SizedBox(height: responsive.spacing(28)),
                    AppButton(label: AppStrings.continueLabel, onPressed: _handleContinue),
                    SizedBox(height: responsive.spacing(24)),
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
