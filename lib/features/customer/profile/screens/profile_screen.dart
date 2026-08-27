import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../state/profile_mock_data.dart';
import '../state/profile_models.dart';
import '../widgets/profile_menu_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _handleMenuTap(BuildContext context, ProfileMenuItemModel item) {
    final route = switch (item.label) {
      AppStrings.myOrders => AppRoutes.orders,
      AppStrings.myAddresses => AppRoutes.addresses,
      AppStrings.paymentMethods => AppRoutes.paymentMethods,
      AppStrings.favorites => AppRoutes.favorites,
      AppStrings.notifications => AppRoutes.notifications,
      'Privacy & Security' => AppRoutes.privacySecurity,
      AppStrings.helpSupport => AppRoutes.helpSupport,
      _ => AppRoutes.helpSupport,
    };
    context.push(route);
  }

  Future<void> _confirmLogout(BuildContext context) async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text(AppStrings.logout),
        content: const Text(AppStrings.logoutConfirm),
        actions: [
          TextButton(onPressed: () => Navigator.of(dialogContext).pop(false), child: const Text(AppStrings.cancel)),
          TextButton(onPressed: () => Navigator.of(dialogContext).pop(true), child: const Text(AppStrings.logout)),
        ],
      ),
    );
    if (shouldLogout == true && context.mounted) {
      context.go(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final user = ProfileMockData.currentUser;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(AppStrings.profileTitle, style: TextStyle(fontWeight: FontWeight.w800)),
        actions: [
          IconButton(
            icon: Icon(Icons.edit_outlined, size: responsive.iconSize(20)),
            onPressed: () => context.push(AppRoutes.editProfile),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: responsive.padding(all: 16),
          children: [
            Row(
              children: [
                Container(
                  width: responsive.size(64),
                  height: responsive.size(64),
                  decoration: BoxDecoration(color: user.avatarColor, shape: BoxShape.circle),
                  child: Icon(Icons.person, color: Colors.white, size: responsive.iconSize(30)),
                ),
                SizedBox(width: responsive.spacing(14)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.name, style: TextStyle(fontSize: responsive.fontSize(17), fontWeight: FontWeight.w800)),
                      SizedBox(height: responsive.spacing(4)),
                      Text(
                        user.email,
                        style: TextStyle(fontSize: responsive.fontSize(12), color: AppColors.textSecondary),
                      ),
                      SizedBox(height: responsive.spacing(4)),
                      Text(
                        '${AppStrings.memberSince} ${user.memberSince}',
                        style: TextStyle(fontSize: responsive.fontSize(11), color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: responsive.spacing(20)),
            const Divider(),
            SizedBox(height: responsive.spacing(8)),
            ...ProfileMockData.menuItems.map(
              (item) => ProfileMenuTile(
                icon: item.icon,
                label: item.label,
                onTap: () => _handleMenuTap(context, item),
              ),
            ),
            SizedBox(height: responsive.spacing(8)),
            const Divider(),
            SizedBox(height: responsive.spacing(8)),
            ProfileMenuTile(
              icon: Icons.logout_rounded,
              label: AppStrings.logout,
              iconColor: AppColors.error,
              onTap: () => _confirmLogout(context),
            ),
          ],
        ),
      ),
    );
  }
}
