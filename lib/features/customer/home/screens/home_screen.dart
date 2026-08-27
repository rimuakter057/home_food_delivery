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
import '../../../../core/widgets/section_header.dart';
import '../../../../core/widgets/store_list_card.dart';
import '../../cart/state/cart_state.dart';
import '../../profile/state/profile_mock_data.dart';
import '../state/home_mock_data.dart';
import '../widgets/category_chip.dart';
import '../widgets/food_card.dart';
import '../widgets/promo_banner_carousel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _selectedCategoryId;

  void _openSearch() {
    context.push(AppRoutes.search);
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final user = ProfileMockData.currentUser;
    final foods = HomeMockData.byCategory(_selectedCategoryId);
    final nearbyStores = HomeMockData.restaurants.take(3).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: responsive.padding(horizontal: 16, vertical: 12),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            AppAssets.homeLocationPin,
                            width: responsive.iconSize(14),
                            height: responsive.iconSize(14),
                          ),
                          SizedBox(width: responsive.spacing(8)),
                          Text(
                            AppStrings.homeDeliveringTo,
                            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              user.deliveryAddress.split(',').first,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.titleSmall.copyWith(color: AppColors.textSecondary),
                            ),
                          ),
                          SvgPicture.asset(
                            AppAssets.homeChevronDown,
                            width: responsive.iconSize(20),
                            height: responsive.iconSize(20),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        InkWell(
                          onTap: () => context.push(AppRoutes.notifications),
                          borderRadius: BorderRadius.circular(responsive.radius(18)),
                          child: Container(
                            width: responsive.size(36),
                            height: responsive.size(36),
                            decoration: const BoxDecoration(color: Color(0xFFF5F5F5), shape: BoxShape.circle),
                            child: Center(
                              child: SvgPicture.asset(
                                AppAssets.homeNotificationBell,
                                width: responsive.iconSize(18),
                                height: responsive.iconSize(18),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: -responsive.spacing(2),
                          top: -responsive.spacing(2),
                          child: Container(
                            padding: responsive.padding(all: 3),
                            constraints: BoxConstraints(minWidth: responsive.size(16), minHeight: responsive.size(16)),
                            decoration: const BoxDecoration(color: AppColors.error, shape: BoxShape.circle),
                            child: Text(
                              '2',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white, fontSize: responsive.fontSize(9), fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: responsive.spacing(10)),
                    InkWell(
                      onTap: () => context.push(AppRoutes.editProfile),
                      borderRadius: BorderRadius.circular(responsive.radius(18)),
                      child: Container(
                        width: responsive.size(36),
                        height: responsive.size(36),
                        decoration: BoxDecoration(
                          color: user.avatarColor,
                          shape: BoxShape.circle,
                          boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.3), blurRadius: responsive.spacing(8), offset: Offset(0, responsive.spacing(2)))],
                        ),
                        child: Icon(Icons.person, color: Colors.white, size: responsive.iconSize(18)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: responsive.spacing(24)),
            GestureDetector(
              onTap: _openSearch,
              child: Container(
                padding: responsive.padding(horizontal: 16, vertical: 15),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(responsive.radius(8)),
                  border: Border.all(color: AppColors.border, width: 0.5),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(AppAssets.search, width: 16, height: 16),
                    SizedBox(width: responsive.spacing(6)),
                    Expanded(child: Text(AppStrings.searchHint, style: AppTextStyles.placeholder)),
                    Container(
                      width: responsive.size(32),
                      height: responsive.size(32),
                      decoration: BoxDecoration(color: AppColors.divider, borderRadius: BorderRadius.circular(responsive.radius(8))),
                      child: SvgPicture.asset(AppAssets.filterSliders, width: 15, height: 15),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: responsive.spacing(24)),
            PromoBannerCarousel(banners: HomeMockData.banners),
            SizedBox(height: responsive.spacing(22)),
            SectionHeader(title: AppStrings.categoriesTitle, onSeeAll: null),
            SizedBox(height: responsive.spacing(12)),
            SizedBox(
              height: responsive.size(84),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: HomeMockData.categories.length,
                separatorBuilder: (_, __) => SizedBox(width: responsive.spacing(16)),
                itemBuilder: (context, index) {
                  final category = HomeMockData.categories[index];
                  final isSelected = category.id == _selectedCategoryId;
                  return CategoryChip(
                    category: category,
                    isSelected: isSelected,
                    onTap: () => setState(() {
                      _selectedCategoryId = isSelected ? null : category.id;
                    }),
                  );
                },
              ),
            ),
            SizedBox(height: responsive.spacing(22)),
            SectionHeader(title: AppStrings.popularKitchensTitle, onSeeAll: _openSearch),
            SizedBox(height: responsive.spacing(12)),
            ...nearbyStores.map(
              (restaurant) => Padding(
                padding: EdgeInsets.only(bottom: responsive.spacing(12)),
                child: StoreListCard(
                  image: Image.asset(AppAssets.storeThumbFreshProduce, fit: BoxFit.cover),
                  title: restaurant.name,
                  rating: restaurant.rating,
                  trailingLabel: restaurant.isOpen ? AppStrings.openNow : AppStrings.closedNow,
                  trailingIsFree: restaurant.isOpen,
                  onTap: () => context.push(AppRoutes.restaurantPath(restaurant.id)),
                ),
              ),
            ),
            SizedBox(height: responsive.spacing(10)),
            SectionHeader(title: AppStrings.recommendedForYouTitle, onSeeAll: _openSearch),
            SizedBox(height: responsive.spacing(12)),
            SizedBox(
              height: responsive.size(210),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: foods.length,
                separatorBuilder: (_, __) => SizedBox(width: responsive.spacing(12)),
                itemBuilder: (context, index) {
                  final food = foods[index];
                  return FoodCard(
                    food: food,
                    onTap: () => context.push(AppRoutes.foodPath(food.id)),
                    onAdd: () => context.read<CartState>().addFood(food, quantity: 1),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
