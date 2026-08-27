import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../navigation/state/navigation_state.dart';
import '../state/cart_state.dart';
import '../widgets/cart_item_tile.dart';
import '../widgets/cart_summary.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  Future<void> _confirmRemove(BuildContext context, CartState cart, String foodId) async {
    final shouldRemove = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text(AppStrings.removeItem),
        content: const Text(AppStrings.removeItemConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text(AppStrings.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text(AppStrings.remove),
          ),
        ],
      ),
    );
    if (shouldRemove == true) {
      cart.removeItem(foodId);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(AppStrings.itemRemovedMessage)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final cart = context.watch<CartState>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(AppStrings.cartTitle, style: AppTextStyles.titleLarge),
      ),
      body: SafeArea(
        child: cart.isEmpty
            ? EmptyStateWidget(
                icon: Icons.shopping_cart_outlined,
                title: AppStrings.emptyCartTitle,
                subtitle: AppStrings.emptyCartSubtitle,
                actionLabel: AppStrings.browseFood,
                onAction: () => context.read<NavigationState>().setIndex(0),
              )
            : Padding(
                padding: responsive.padding(horizontal: 16),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: responsive.padding(vertical: 12),
                        child: Text('${cart.items.length} items', style: AppTextStyles.bodySmall),
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        children: cart.items
                            .map(
                              (item) => CartItemTile(
                                item: item,
                                onIncrement: () => cart.incrementQuantity(item.food.id),
                                onDecrement: () => cart.decrementQuantity(item.food.id),
                                onRemove: () => _confirmRemove(context, cart, item.food.id),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Padding(
                      padding: responsive.padding(vertical: 16),
                      child: Column(
                        children: [
                          CartSummary(cart: cart),
                          SizedBox(height: responsive.spacing(16)),
                          AppButton(
                            label: AppStrings.proceedToCheckout,
                            onPressed: () => context.push(AppRoutes.checkout),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
