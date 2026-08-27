import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/widgets/main_bottom_nav_bar.dart';
import '../../dashboard/screens/shopper_dashboard_screen.dart';
import '../../earnings/screens/shopper_earnings_screen.dart';
import '../../orders/screens/shopper_orders_screen.dart';
import '../../profile/screens/shopper_profile_screen.dart';
import '../state/shopper_navigation_state.dart';

/// The Shopper role's bottom-nav shell (Figma "Nav Bar dASHER" component):
/// Dashboard, Orders, Earnings, Profile — mirrors [HostShellScreen]'s
/// IndexedStack pattern, reusing [MainBottomNavBar] with Shopper's own items.
class ShopperShellScreen extends StatelessWidget {
  const ShopperShellScreen({super.key});

  static const _tabs = [
    ShopperDashboardScreen(),
    ShopperOrdersScreen(),
    ShopperEarningsScreen(),
    ShopperProfileScreen(),
  ];

  static const _items = [
    (label: 'Dashboard', asset: AppAssets.shopperNavDashboard),
    (label: 'Orders', asset: AppAssets.shopperNavOrders),
    (label: 'Earnings', asset: AppAssets.shopperNavEarnings),
    (label: 'Profile', asset: AppAssets.shopperNavProfile),
  ];

  @override
  Widget build(BuildContext context) {
    final currentIndex = context.watch<ShopperNavigationState>().currentIndex;

    return Scaffold(
      body: IndexedStack(index: currentIndex, children: _tabs),
      bottomNavigationBar: MainBottomNavBar(
        currentIndex: currentIndex,
        items: _items,
        badgeIndex: -1,
        onTap: (index) => context.read<ShopperNavigationState>().setIndex(index),
      ),
    );
  }
}
