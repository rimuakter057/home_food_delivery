import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/widgets/main_bottom_nav_bar.dart';
import '../../dashboard/screens/host_dashboard_screen.dart';
import '../../profile/screens/host_profile_screen.dart';
import '../../properties/screens/my_properties_screen.dart';
import '../../requests/screens/order_requests_screen.dart';
import '../state/host_navigation_state.dart';

/// The Host role's bottom-nav shell (Figma "Nav Bar Host" component):
/// Dashboard, Properties, Requests, Profile — mirrors [MainShellScreen]'s
/// IndexedStack pattern, reusing [MainBottomNavBar] with Host's own items.
class HostShellScreen extends StatelessWidget {
  const HostShellScreen({super.key});

  static const _tabs = [
    HostDashboardScreen(),
    MyPropertiesScreen(),
    OrderRequestsScreen(),
    HostProfileScreen(),
  ];

  static const _items = [
    (label: 'Dashboard', asset: AppAssets.hostNavDashboard),
    (label: 'Properties', asset: AppAssets.hostNavProperties),
    (label: 'Requests', asset: AppAssets.hostNavRequests),
    (label: 'Profile', asset: AppAssets.hostNavProfile),
  ];

  @override
  Widget build(BuildContext context) {
    final currentIndex = context.watch<HostNavigationState>().currentIndex;

    return Scaffold(
      body: IndexedStack(index: currentIndex, children: _tabs),
      bottomNavigationBar: MainBottomNavBar(
        currentIndex: currentIndex,
        items: _items,
        badgeIndex: -1,
        onTap: (index) => context.read<HostNavigationState>().setIndex(index),
      ),
    );
  }
}
