import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_helper.dart';

enum AuthTab { signIn, signUp }

/// The Sign In / Sign Up pill switcher that overlaps the bottom edge of
/// [AuthHeroHeader] on the login and sign-up screens.
class AuthTabSwitcher extends StatelessWidget {
  const AuthTabSwitcher({super.key, required this.active, required this.onChanged});

  final AuthTab active;
  final ValueChanged<AuthTab> onChanged;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Container(
      width: responsive.size(342),
      padding: responsive.padding(all: 5),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(responsive.radius(12)),
        border: Border(bottom: BorderSide(color: AppColors.primaryDark)),
        boxShadow: [
          BoxShadow(color: AppColors.cardShadow, blurRadius: responsive.spacing(4), offset: Offset(0, responsive.spacing(2))),
        ],
      ),
      child: Row(
        children: [
          Expanded(child: _tab(context, AppStrings.authTabSignIn, AuthTab.signIn)),
          SizedBox(width: responsive.spacing(4)),
          Expanded(child: _tab(context, AppStrings.authTabSignUp, AuthTab.signUp)),
        ],
      ),
    );
  }

  Widget _tab(BuildContext context, String label, AuthTab tab) {
    final responsive = context.responsive;
    final isActive = tab == active;
    return InkWell(
      onTap: () => onChanged(tab),
      borderRadius: BorderRadius.circular(responsive.radius(8)),
      child: Container(
        height: responsive.size(48),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(responsive.radius(8)),
          border: isActive ? null : Border.all(color: AppColors.primary, width: 2),
        ),
        child: Text(
          label,
          style: AppTextStyles.buttonLabelLarge.copyWith(
            color: isActive ? AppColors.textOnPrimary : AppColors.primary,
          ),
        ),
      ),
    );
  }
}
