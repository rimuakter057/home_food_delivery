import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/widgets/main_bottom_nav_bar.dart';
import '../../cart/screens/cart_screen.dart';
import '../../cart/state/cart_state.dart';
import '../../home/screens/home_screen.dart';
import '../../orders/screens/order_history_screen.dart';
import '../../profile/screens/profile_screen.dart';
import '../../search/screens/search_screen.dart';
import '../state/navigation_state.dart';

class MainShellScreen extends StatelessWidget {
  const MainShellScreen({super.key});

  // Order matches the Figma nav bar: Home, Stores, Orders, Cart, Profile.
  // "Stores" reuses the existing browse/search screen.
  static const _tabs = [
    HomeScreen(),
    SearchScreen(),
    OrderHistoryScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final currentIndex = context.watch<NavigationState>().currentIndex;
    final cartCount = context.watch<CartState>().itemCount;

    return Scaffold(
      body: IndexedStack(index: currentIndex, children: _tabs),
      bottomNavigationBar: MainBottomNavBar(
        currentIndex: currentIndex,
        cartBadgeCount: cartCount,
        onTap: (index) => context.read<NavigationState>().setIndex(index),
      ),
    );
  }
}
