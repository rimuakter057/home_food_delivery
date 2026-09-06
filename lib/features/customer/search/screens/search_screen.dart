import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/widgets/app_filter_chip.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../../../core/widgets/store_list_card.dart';
import '../../home/state/home_mock_data.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  String _query = '';
  int _selectedFilter = 0;

  static const _filters = [
    'All Stores',
    '🛒 Grocery',
    '🌿 Organic',
    '⚡ Convenience',
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<dynamic> get _matchedRestaurants => HomeMockData.restaurants
      .where((r) => r.name.toLowerCase().contains(_query.toLowerCase()))
      .toList();

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final stores = _matchedRestaurants;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: responsive.padding(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () => context.pop(),
                      borderRadius: BorderRadius.circular(
                        responsive.radius(12),
                      ),
                      child: SvgPicture.asset(
                        AppAssets.chevronBack,
                        width: responsive.iconSize(24),
                        height: responsive.iconSize(24),
                        colorFilter: const ColorFilter.mode(
                          AppColors.primary,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  Text(AppStrings.searchTitle, style: AppTextStyles.titleLarge),
                ],
              ),
              SizedBox(height: responsive.spacing(16)),
              Container(
                padding: responsive.padding(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(responsive.radius(14)),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.cardShadow,
                      blurRadius: responsive.spacing(12),
                      offset: Offset(0, responsive.spacing(4)),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppAssets.search,
                      width: 18,
                      height: 18,
                      colorFilter: const ColorFilter.mode(
                        AppColors.textSecondary,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: responsive.spacing(10)),
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        onChanged: (value) => setState(() => _query = value),
                        style: AppTextStyles.bodyMedium,
                        decoration: InputDecoration(
                          hintText: AppStrings.searchForAddress,
                          hintStyle: AppTextStyles.placeholder,
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),
                    SizedBox(width: responsive.spacing(8)),
                    Container(
                      width: responsive.size(36),
                      height: responsive.size(36),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(
                          responsive.radius(10),
                        ),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          AppAssets.filterSliders,
                          width: 16,
                          height: 16,
                          colorFilter: const ColorFilter.mode(
                            AppColors.primary,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: responsive.spacing(12)),
              SizedBox(
                height: responsive.size(28),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _filters.length,
                  separatorBuilder: (_, __) =>
                      SizedBox(width: responsive.spacing(8)),
                  itemBuilder: (context, index) => AppFilterChip(
                    label: _filters[index],
                    isSelected: index == _selectedFilter,
                    onTap: () => setState(() => _selectedFilter = index),
                  ),
                ),
              ),
              SizedBox(height: responsive.spacing(16)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${stores.length} stores found',
                    style: AppTextStyles.bodySmall,
                  ),
                  Row(
                    children: [
                      Text('Sort: ', style: AppTextStyles.bodySmall),
                      Text('⭐ Rating', style: AppTextStyles.labelSmall),
                    ],
                  ),
                ],
              ),
              SizedBox(height: responsive.spacing(12)),
              Expanded(
                child: stores.isEmpty
                    ? const EmptyStateWidget(
                        icon: Icons.storefront_outlined,
                        title: AppStrings.noResultsTitle,
                        subtitle: AppStrings.noResultsSubtitle,
                      )
                    : ListView.separated(
                        itemCount: stores.length,
                        separatorBuilder: (_, __) =>
                            SizedBox(height: responsive.spacing(12)),
                        itemBuilder: (context, index) {
                          final restaurant = stores[index];
                          return StoreListCard(
                            image: Image.asset(
                              AppAssets.storeThumbFreshProduce,
                              fit: BoxFit.cover,
                            ),
                            title: restaurant.name,
                            rating: restaurant.rating,
                            trailingLabel: restaurant.isOpen
                                ? AppStrings.openNow
                                : AppStrings.closedNow,
                            trailingIsFree: restaurant.isOpen,
                            onTap: () => context.push(
                              AppRoutes.restaurantPath(restaurant.id),
                            ),
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
