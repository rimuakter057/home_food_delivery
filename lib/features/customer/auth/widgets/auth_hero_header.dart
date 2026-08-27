import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_helper.dart';

/// The green rounded-bottom hero header shared by every auth screen
/// (Sign In, Sign Up, Forgot Password, OTP, Reset Password). Pass
/// [overlapping] (e.g. an [AuthTabSwitcher]) to render a card that sits
/// on the header's bottom edge, as Figma does for Sign In / Sign Up.
class AuthHeroHeader extends StatelessWidget {
  const AuthHeroHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.showLogo = false,
    this.overlapping,
    this.onBack,
  });

  final String title;
  final String subtitle;
  final bool showLogo;
  final Widget? overlapping;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: double.infinity,
          padding: responsive.padding(horizontal: 24, vertical: 32).copyWith(
                top: responsive.spacing(showLogo ? 74 : 120),
              ),
          decoration: BoxDecoration(
            color: AppColors.primaryDark,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(responsive.radius(24))),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (showLogo) ...[
                Image.asset(AppAssets.brandLogo, width: responsive.size(99)),
                SizedBox(height: responsive.spacing(12)),
              ],
              Text(
                title,
                textAlign: TextAlign.center,
                style: AppTextStyles.headlineMedium,
              ),
              SizedBox(height: responsive.spacing(4)),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: AppTextStyles.heroSubtitle,
              ),
            ],
          ),
        ),
        Positioned(
          left: responsive.spacing(30),
          top: responsive.spacing(64),
          child: InkWell(
            onTap: onBack ?? () => Navigator.of(context).maybePop(),
            borderRadius: BorderRadius.circular(responsive.radius(12)),
            child: SvgPicture.asset(
              AppAssets.chevronBack,
              width: responsive.iconSize(24),
              height: responsive.iconSize(24),
              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
          ),
        ),
        if (overlapping != null)
          Positioned(bottom: responsive.spacing(-29), child: overlapping!),
      ],
    );
  }
}
