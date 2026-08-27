import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/quantity_selector.dart';
import '../../../../core/widgets/rating_badge.dart';
import '../../cart/state/cart_state.dart';
import '../../favorites/state/favorites_state.dart';
import '../../home/state/home_mock_data.dart';

class FoodDetailScreen extends StatefulWidget {
  const FoodDetailScreen({super.key, required this.foodId});

  final String foodId;

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final food = HomeMockData.foodById(widget.foodId);
    final isFavorite = context.watch<FavoritesState>().isFavorite(food.id);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: responsive.padding(all: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => context.pop(),
                          customBorder: const CircleBorder(),
                          child: Container(
                            width: responsive.size(36),
                            height: responsive.size(36),
                            decoration: BoxDecoration(
                              color: AppColors.background,
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.divider),
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                AppAssets.chevronBack,
                                width: responsive.iconSize(16),
                                height: responsive.iconSize(16),
                                colorFilter: const ColorFilter.mode(AppColors.textPrimary, BlendMode.srcIn),
                              ),
                            ),
                          ),
                        ),
                        _CircleIconButton(
                          icon: isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                          iconColor: isFavorite ? AppColors.error : AppColors.textPrimary,
                          onTap: () {
                            context.read<FavoritesState>().toggleFavorite(food);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  isFavorite
                                      ? AppStrings.removedFromFavoritesMessage
                                      : AppStrings.addedToFavoritesMessage,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: responsive.spacing(16)),
                    AspectRatio(
                      aspectRatio: 1.3,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(responsive.radius(16)),
                        child: Image.asset(AppAssets.foodPhotoGeneric, fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(height: responsive.spacing(18)),
                    Row(
                      children: [
                        Icon(
                          food.isVeg ? Icons.eco_rounded : Icons.set_meal_rounded,
                          size: responsive.iconSize(16),
                          color: food.isVeg ? AppColors.success : AppColors.error,
                        ),
                        SizedBox(width: responsive.spacing(6)),
                        Text(
                          food.isVeg ? AppStrings.vegLabel : AppStrings.nonVegLabel,
                          style: TextStyle(fontSize: responsive.fontSize(12), color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                    SizedBox(height: responsive.spacing(8)),
                    Text(
                      food.name,
                      style: TextStyle(fontSize: responsive.fontSize(22), fontWeight: FontWeight.w800),
                    ),
                    SizedBox(height: responsive.spacing(10)),
                    Row(
                      children: [
                        RatingBadge(rating: food.rating),
                        SizedBox(width: responsive.spacing(12)),
                        Icon(Icons.local_fire_department_outlined,
                            size: responsive.iconSize(15), color: AppColors.textSecondary),
                        SizedBox(width: responsive.spacing(4)),
                        Text(
                          '${food.calories} ${AppStrings.calories}',
                          style: TextStyle(fontSize: responsive.fontSize(12), color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                    SizedBox(height: responsive.spacing(20)),
                    Text(
                      AppStrings.foodDescriptionTitle,
                      style: TextStyle(fontSize: responsive.fontSize(15), fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: responsive.spacing(8)),
                    Text(
                      food.description,
                      style: TextStyle(
                        fontSize: responsive.fontSize(13),
                        color: AppColors.textSecondary,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: responsive.padding(all: 16),
              decoration: const BoxDecoration(
                color: AppColors.surface,
                border: Border(top: BorderSide(color: AppColors.divider)),
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.quantityLabel,
                        style: TextStyle(fontSize: responsive.fontSize(11), color: AppColors.textSecondary),
                      ),
                      SizedBox(height: responsive.spacing(6)),
                      QuantitySelector(
                        quantity: _quantity,
                        onIncrement: () => setState(() => _quantity++),
                        onDecrement: () => setState(() => _quantity--),
                      ),
                    ],
                  ),
                  SizedBox(width: responsive.spacing(16)),
                  Expanded(
                    child: AppButton(
                      label:
                          '${AppStrings.addToCart} · ${AppStrings.currencySymbol}${(food.price * _quantity).toStringAsFixed(2)}',
                      icon: Icons.shopping_bag_outlined,
                      onPressed: () {
                        context.read<CartState>().addFood(food, quantity: _quantity);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text(AppStrings.addedToCartMessage)),
                        );
                        context.pop();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({required this.icon, required this.onTap, this.iconColor});

  final IconData icon;
  final VoidCallback onTap;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: responsive.size(36),
        height: responsive.size(36),
        decoration: BoxDecoration(
          color: AppColors.background,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.divider),
        ),
        child: Icon(icon, size: responsive.iconSize(16), color: iconColor ?? AppColors.textPrimary),
      ),
    );
  }
}
