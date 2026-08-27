import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../home/widgets/food_card.dart';
import '../state/favorites_state.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final favorites = context.watch<FavoritesState>().favorites;

    return Scaffold(
      appBar: const CustomAppBar(title: AppStrings.favoritesTitle),
      body: SafeArea(
        child: favorites.isEmpty
            ? const EmptyStateWidget(
                icon: Icons.favorite_border_rounded,
                title: AppStrings.emptyFavoritesTitle,
                subtitle: AppStrings.emptyFavoritesSubtitle,
              )
            : GridView.builder(
                padding: responsive.padding(all: 16),
                itemCount: favorites.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: responsive.spacing(12),
                  crossAxisSpacing: responsive.spacing(12),
                  childAspectRatio: 0.72,
                ),
                itemBuilder: (context, index) {
                  final food = favorites[index];
                  return FoodCard(
                    food: food,
                    onTap: () => context.push(AppRoutes.foodPath(food.id)),
                  );
                },
              ),
      ),
    );
  }
}
