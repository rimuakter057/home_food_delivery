import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../state/auth_validators.dart';
import '../widgets/auth_hero_header.dart';
import '../widgets/auth_tab_switcher.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    super.key,
    this.successRoute = AppRoutes.enableLocation,
    this.signInRoute = AppRoutes.login,
    this.backRoute = AppRoutes.roleLanding,
  });

  /// Where to navigate after a successful sign-up — lets other roles (e.g.
  /// Host) reuse this exact screen and land on their own flow instead of
  /// the customer's location-enable step.
  final String successRoute;

  /// Where the "Sign In" tab and back chevron go — kept in sync with
  /// [successRoute] so the role context isn't lost mid-flow.
  final String signInRoute;
  final String backRoute;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _businessNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _businessNameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    setState(() => _isLoading = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text(AppStrings.signUpSuccessMessage)),
    );
    context.go(widget.successRoute);
  }

  Widget _passwordToggle(bool obscure, VoidCallback onTap) {
    return IconButton(
      icon: obscure
          ? SvgPicture.asset(
              AppAssets.eyeToggle,
              width: 18,
              height: 18,
              colorFilter: const ColorFilter.mode(AppColors.textSecondary, BlendMode.srcIn),
            )
          : const Icon(Icons.visibility_off_outlined),
      onPressed: onTap,
    );
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
            AuthHeroHeader(
              title: AppStrings.signUpTitle,
              subtitle: AppStrings.signUpSubtitle,
              showLogo: true,
              onBack: () => context.go(widget.backRoute),
              overlapping: AuthTabSwitcher(
                active: AuthTab.signUp,
                onChanged: (tab) => tab == AuthTab.signIn ? context.go(widget.signInRoute) : null,
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
                      label: AppStrings.hostBusinessNameOptional,
                      hint: AppStrings.hostBusinessNameHint,
                      controller: _businessNameController,
                    ),
                    SizedBox(height: responsive.spacing(12)),
                    AppTextField(
                      label: AppStrings.password,
                      hint: AppStrings.enterPassword,
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      validator: AuthValidators.password,
                      suffixIcon: _passwordToggle(_obscurePassword, () => setState(() => _obscurePassword = !_obscurePassword)),
                    ),
                    SizedBox(height: responsive.spacing(12)),
                    AppTextField(
                      label: AppStrings.confirmPassword,
                      hint: AppStrings.enterConfirmPassword,
                      controller: _confirmPasswordController,
                      obscureText: _obscurePassword,
                      validator: AuthValidators.confirmPassword(() => _passwordController.text),
                      suffixIcon: _passwordToggle(_obscurePassword, () => setState(() => _obscurePassword = !_obscurePassword)),
                    ),
                    SizedBox(height: responsive.spacing(28)),
                    AppButton(label: AppStrings.signUpButton, isLoading: _isLoading, onPressed: _handleSignUp),
                    SizedBox(height: responsive.spacing(16)),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: AppTextStyles.bodySmall.copyWith(color: AppColors.textMuted),
                        children: [
                          const TextSpan(text: '${AppStrings.agreeToTermsPrefix} '),
                          const TextSpan(text: AppStrings.termsOfService, style: TextStyle(color: AppColors.link)),
                          const TextSpan(text: ' ${AppStrings.and} '),
                          const TextSpan(text: AppStrings.privacyPolicy, style: TextStyle(color: AppColors.link)),
                        ],
                      ),
                    ),
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
