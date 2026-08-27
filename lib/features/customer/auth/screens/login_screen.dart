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

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
    this.successRoute = AppRoutes.home,
    this.signUpRoute = AppRoutes.signup,
    this.backRoute = AppRoutes.roleLanding,
  });

  /// Where to navigate after a successful login — lets other roles (e.g.
  /// Host) reuse this exact screen and land on their own home instead of
  /// the customer shell.
  final String successRoute;

  /// Where the "Sign Up" tab and back chevron go — kept in sync with
  /// [successRoute] so the role context isn't lost mid-flow.
  final String signUpRoute;
  final String backRoute;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _rememberMe = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    setState(() => _isLoading = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text(AppStrings.loginSuccessMessage)),
    );
    context.go(widget.successRoute);
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
              title: AppStrings.loginTitle,
              subtitle: AppStrings.loginSubtitle,
              showLogo: true,
              onBack: () => context.go(widget.backRoute),
              overlapping: AuthTabSwitcher(
                active: AuthTab.signIn,
                onChanged: (tab) => tab == AuthTab.signUp ? context.go(widget.signUpRoute) : null,
              ),
            ),
            Padding(
              padding: responsive.padding(horizontal: 24).copyWith(top: responsive.spacing(70)),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    SizedBox(height: responsive.spacing(8)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => setState(() => _rememberMe = !_rememberMe),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: responsive.size(14.5),
                                height: responsive.size(14.5),
                                decoration: BoxDecoration(
                                  color: _rememberMe ? const Color(0xFF167EE6) : Colors.transparent,
                                  border: Border.all(color: const Color(0xFF167EE6), width: 1.2),
                                  borderRadius: BorderRadius.circular(responsive.radius(3)),
                                ),
                                child: _rememberMe
                                    ? const Icon(Icons.check, size: 11, color: Colors.white)
                                    : null,
                              ),
                              SizedBox(width: responsive.spacing(8)),
                              Text(
                                AppStrings.rememberMe,
                                style: AppTextStyles.labelSmall.copyWith(color: const Color(0xFF167EE6), fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () => context.push(AppRoutes.forgotPassword),
                          child: Text(
                            AppStrings.forgotPassword,
                            style: AppTextStyles.labelSmall.copyWith(color: const Color(0xFF167EE6), fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: responsive.spacing(24)),
                    AppButton(label: AppStrings.loginButton, isLoading: _isLoading, onPressed: _handleLogin),
                    SizedBox(height: responsive.spacing(24)),
                    Text(
                      AppStrings.orLogInWith,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.fieldLabel.copyWith(color: AppColors.primary, fontSize: 12),
                    ),
                    SizedBox(height: responsive.spacing(16)),
                    _SocialButton(
                      label: AppStrings.signInWithApple,
                      backgroundColor: AppColors.primary,
                      icon: AppAssets.appleLogo,
                      onTap: () {},
                    ),
                    SizedBox(height: responsive.spacing(16)),
                    _SocialButton(
                      label: AppStrings.signInWithGoogle,
                      backgroundColor: const Color(0xFF167EE6),
                      icon: AppAssets.googleLogo,
                      onTap: () {},
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

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.label,
    required this.backgroundColor,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final Color backgroundColor;
  final String icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return SizedBox(
      width: double.infinity,
      height: responsive.size(48),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(responsive.radius(8))),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(icon, width: 18, height: 18),
            SizedBox(width: responsive.spacing(8)),
            Text(label, style: AppTextStyles.buttonLabel),
          ],
        ),
      ),
    );
  }
}
