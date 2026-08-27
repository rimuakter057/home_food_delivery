import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_helper.dart';

/// The role-selection landing screen (Figma node 493:4184): lets a new
/// user pick which side of the marketplace they're joining before signing
/// up. All three roles are wired to real flows.
class RoleLandingScreen extends StatelessWidget {
  const RoleLandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final w = constraints.maxWidth;
          final h = constraints.maxHeight;
          return Stack(
            children: [
              _blob(left: 0.4732 * w, top: -0.0550 * h, size: 0.6533 * w),
              _blob(left: -0.2243 * w, top: 0.2587 * h, size: 1.0241 * w),
              _blob(left: 0.1935 * w, top: 0.7431 * h, size: 0.7212 * w),
              SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    padding: responsive.padding(horizontal: 24, vertical: 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(AppAssets.brandLogo, width: responsive.size(241)),
                        SizedBox(height: responsive.spacing(12)),
                        Text(
                          AppStrings.appTagline,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.fieldLabel.copyWith(
                            color: Colors.white.withValues(alpha: 0.85),
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: responsive.spacing(24)),
                        _RoleButton(
                          icon: AppAssets.roleCustomerBag,
                          label: AppStrings.becomeCustomer,
                          variant: _RoleButtonVariant.translucent,
                          onTap: () => context.go(AppRoutes.signup),
                        ),
                        SizedBox(height: responsive.spacing(16)),
                        _RoleButton(
                          icon: AppAssets.roleHostBuilding,
                          label: AppStrings.becomePropertyHost,
                          variant: _RoleButtonVariant.solid,
                          onTap: () => context.go(AppRoutes.hostSignup),
                        ),
                        SizedBox(height: responsive.spacing(16)),
                        _RoleButton(
                          icon: AppAssets.roleShopperBike,
                          label: AppStrings.becomeShopper,
                          variant: _RoleButtonVariant.translucent,
                          onTap: () => context.go(AppRoutes.shopperSignup),
                        ),
                        SizedBox(height: responsive.spacing(24)),
                        Text(
                          AppStrings.alreadyHaveAccount,
                          style: AppTextStyles.bodyMedium.copyWith(color: const Color(0xFFB4D1B5)),
                        ),
                        SizedBox(height: responsive.spacing(12)),
                        SizedBox(
                          width: double.infinity,
                          height: responsive.size(48),
                          child: OutlinedButton(
                            onPressed: () => context.go(AppRoutes.login),
                            style: OutlinedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              side: const BorderSide(color: Colors.white, width: 0.8),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(responsive.radius(8))),
                            ),
                            child: Text(AppStrings.authTabSignIn, style: AppTextStyles.buttonLabel),
                          ),
                        ),
                        SizedBox(height: responsive.spacing(20)),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              AppAssets.checkmarkSmall,
                              width: 12,
                              height: 12,
                              colorFilter: ColorFilter.mode(Colors.white.withValues(alpha: 0.64), BlendMode.srcIn),
                            ),
                            SizedBox(width: responsive.spacing(6)),
                            Flexible(
                              child: Text(
                                AppStrings.continueAgreeTerms,
                                textAlign: TextAlign.center,
                                style: AppTextStyles.caption.copyWith(color: Colors.white.withValues(alpha: 0.64)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _blob({required double left, required double top, required double size}) {
    return Positioned(
      left: left,
      top: top,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.07), shape: BoxShape.circle),
      ),
    );
  }
}

enum _RoleButtonVariant { solid, translucent }

class _RoleButton extends StatelessWidget {
  const _RoleButton({required this.icon, required this.label, required this.variant, required this.onTap});

  final String icon;
  final String label;
  final _RoleButtonVariant variant;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final isSolid = variant == _RoleButtonVariant.solid;
    final foreground = isSolid ? AppColors.primaryDark : Colors.white;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(responsive.radius(8)),
      child: Container(
        width: double.infinity,
        height: responsive.size(48),
        padding: responsive.padding(horizontal: 24),
        decoration: BoxDecoration(
          color: isSolid ? Colors.white : Colors.white.withValues(alpha: 0.15),
          border: isSolid ? null : Border.all(color: Colors.white.withValues(alpha: 0.4)),
          borderRadius: BorderRadius.circular(responsive.radius(8)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(icon, width: responsive.iconSize(32), height: responsive.iconSize(32)),
            SizedBox(width: responsive.spacing(12)),
            Flexible(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.titleSmall.copyWith(color: foreground, fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            SizedBox(width: responsive.spacing(10)),
            SvgPicture.asset(
              isSolid ? AppAssets.playArrowDark : AppAssets.playArrowLight,
              width: responsive.iconSize(24),
              height: responsive.iconSize(24),
            ),
          ],
        ),
      ),
    );
  }
}
