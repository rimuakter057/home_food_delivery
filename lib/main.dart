import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/constants/app_strings.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/customer/cart/state/cart_state.dart';
import 'features/customer/favorites/state/favorites_state.dart';
import 'features/customer/navigation/state/navigation_state.dart';
import 'features/customer/orders/state/orders_state.dart';
import 'features/host/navigation/state/host_navigation_state.dart';
import 'features/shopper/navigation/state/shopper_navigation_state.dart';

void main() {
  runApp(const HomeFoodDeliveryApp());
}

class HomeFoodDeliveryApp extends StatelessWidget {
  const HomeFoodDeliveryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavigationState()),
        ChangeNotifierProvider(create: (_) => CartState()),
        ChangeNotifierProvider(create: (_) => FavoritesState()),
        ChangeNotifierProvider(create: (_) => OrdersState()),
        ChangeNotifierProvider(create: (_) => HostNavigationState()),
        ChangeNotifierProvider(create: (_) => ShopperNavigationState()),
      ],
      child: MaterialApp.router(
        title: AppStrings.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
