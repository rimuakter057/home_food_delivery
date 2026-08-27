import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/widgets/app_filter_chip.dart';
import '../../../../core/widgets/rating_badge.dart';
import '../../cart/state/cart_state.dart';
import '../../home/state/home_mock_data.dart';
import '../../home/state/home_models.dart';
import '../../home/widgets/food_card.dart';

class RestaurantDetailScreen extends StatefulWidget {
  const RestaurantDetailScreen({super.key, required this.restaurantId});

  final String restaurantId;

  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  int _selectedCategory = 0;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final restaurant = HomeMockData.restaurantById(widget.restaurantId);
    final cartCount = context.watch<CartState>().itemCount;
    String categoryName(String id) =>
        HomeMockData.categories.firstWhere((c) => c.id == id, orElse: () => CategoryModel(id: id, name: id, emoji: '🍽️')).name;
    final categoryIds = ['All', ...{for (final f in restaurant.menu) f.categoryId}];
    final categories = categoryIds.map((id) => id == 'All' ? 'All' : categoryName(id)).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: responsive.padding(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () => context.pop(),
                borderRadius: BorderRadius.circular(responsive.radius(12)),
                child: SvgPicture.asset(
                  AppAssets.chevronBack,
                  width: responsive.iconSize(24),
                  height: responsive.iconSize(24),
                  colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
                ),
              ),
              SizedBox(height: responsive.spacing(12)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: responsive.size(64),
                    height: responsive.size(64),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5E9),
                      border: Border.all(color: const Color(0xFFC8E6C9), width: 2),
                      borderRadius: BorderRadius.circular(responsive.radius(8)),
                    ),
                    child: Icon(restaurant.icon, color: AppColors.primary, size: responsive.iconSize(28)),
                  ),
                  SizedBox(width: responsive.spacing(12)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(restaurant.name, style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold)),
                        Text(restaurant.cuisine, style: AppTextStyles.bodySmall),
                        SizedBox(height: responsive.spacing(8)),
                        Row(
                          children: [
                            RatingBadge(rating: restaurant.rating),
                            SizedBox(width: responsive.spacing(12)),
                            Icon(Icons.local_shipping_outlined, size: responsive.iconSize(12), color: AppColors.primary),
                            SizedBox(width: responsive.spacing(4)),
                            Text(
                              restaurant.isOpen ? 'Free delivery' : AppStrings.closedNow,
                              style: AppTextStyles.bodySmall.copyWith(color: AppColors.primary),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      InkWell(
                        onTap: () => context.push(AppRoutes.cart),
                        borderRadius: BorderRadius.circular(responsive.radius(8)),
                        child: Container(
                          padding: responsive.padding(horizontal: 12, vertical: 5),
                          decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(responsive.radius(8))),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.shopping_cart_outlined, size: responsive.iconSize(16), color: Colors.white),
                              SizedBox(width: responsive.spacing(4)),
                              Text(AppStrings.cartTitle.split(' ').last, style: AppTextStyles.titleSmall.copyWith(color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                      if (cartCount > 0)
                        Positioned(
                          right: -responsive.spacing(6),
                          top: -responsive.spacing(6),
                          child: Container(
                            padding: responsive.padding(all: 2),
                            constraints: BoxConstraints(minWidth: responsive.size(18), minHeight: responsive.size(18)),
                            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                            child: Text(
                              '$cartCount',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: AppColors.primary, fontSize: responsive.fontSize(11), fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: responsive.spacing(16)),
              SizedBox(
                height: responsive.size(28),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (_, __) => SizedBox(width: responsive.spacing(8)),
                  itemBuilder: (context, index) => AppFilterChip(
                    label: categories[index],
                    isSelected: index == _selectedCategory,
                    onTap: () => setState(() => _selectedCategory = index),
                  ),
                ),
              ),
              SizedBox(height: responsive.spacing(16)),
              Expanded(
                child: Builder(
                  builder: (context) {
                    final selectedId = categoryIds[_selectedCategory];
                    final items = selectedId == 'All'
                        ? restaurant.menu
                        : restaurant.menu.where((f) => f.categoryId == selectedId).toList();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${items.length} items', style: AppTextStyles.bodySmall),
                            Container(
                              padding: responsive.padding(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: AppColors.surface,
                                borderRadius: BorderRadius.circular(responsive.radius(8)),
                                border: Border.all(color: AppColors.divider),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                    AppAssets.filterSliders,
                                    width: responsive.iconSize(14),
                                    height: responsive.iconSize(14),
                                    colorFilter: const ColorFilter.mode(AppColors.textSecondary, BlendMode.srcIn),
                                  ),
                                  SizedBox(width: responsive.spacing(6)),
                                  Text(AppStrings.filterLabel, style: AppTextStyles.bodySmall),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: responsive.spacing(12)),
                        Expanded(
                          child: GridView.builder(
                            itemCount: items.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: responsive.spacing(12),
                              crossAxisSpacing: responsive.spacing(12),
                              childAspectRatio: 0.85,
                            ),
                            itemBuilder: (context, index) {
                              final food = items[index];
                              return FoodCard(
                                food: food,
                                onTap: () => context.push(AppRoutes.foodPath(food.id)),
                                onAdd: () => context.read<CartState>().addFood(food, quantity: 1),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
