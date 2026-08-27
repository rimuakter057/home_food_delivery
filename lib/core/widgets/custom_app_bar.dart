import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../constants/app_assets.dart';
import '../constants/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../utils/responsive_helper.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showBackButton = true,
    this.onBackPressed,
  });

  final String title;
  final List<Widget>? actions;
  final bool showBackButton;
  final VoidCallback? onBackPressed;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return AppBar(
      leading: showBackButton
          ? IconButton(
              icon: SvgPicture.asset(
                AppAssets.chevronBack,
                width: responsive.iconSize(24),
                height: responsive.iconSize(24),
                colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
              ),
              onPressed: onBackPressed ?? () => context.pop(),
            )
          : null,
      title: Text(title, style: AppTextStyles.titleLarge),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
