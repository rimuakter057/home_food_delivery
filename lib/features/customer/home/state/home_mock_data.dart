import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import 'home_models.dart';

/// Plain mock catalog for the whole app — screens read directly from these
/// lists, no repository/service layer sits in front of them.
class HomeMockData {
  HomeMockData._();

  static const List<CategoryModel> categories = [
    CategoryModel(id: 'cat_rice', name: 'Rice & Curry', emoji: '🍚'),
    CategoryModel(id: 'cat_snacks', name: 'Snacks', emoji: '🥟'),
    CategoryModel(id: 'cat_dessert', name: 'Dessert', emoji: '🍨'),
    CategoryModel(id: 'cat_drinks', name: 'Drinks', emoji: '☕'),
    CategoryModel(id: 'cat_soup', name: 'Soup', emoji: '🍲'),
    CategoryModel(id: 'cat_bakery', name: 'Bakery', emoji: '🍞'),
  ];

  static const List<PromoBannerModel> banners = [
    PromoBannerModel(
      id: 'banner_1',
      title: '30% off your first order',
      subtitle: 'Use code HOME30 at checkout',
      gradientColors: AppColors.gradientOrange,
    ),
    PromoBannerModel(
      id: 'banner_2',
      title: 'Free delivery this weekend',
      subtitle: 'On orders above \$15',
      gradientColors: AppColors.gradientTeal,
    ),
    PromoBannerModel(
      id: 'banner_3',
      title: 'New kitchens just joined',
      subtitle: 'Explore fresh home chefs nearby',
      gradientColors: AppColors.gradientPurple,
    ),
  ];

  static const List<RestaurantModel> restaurants = [
    RestaurantModel(
      id: 'rest_1',
      name: "Amara's Kitchen",
      cuisine: 'Bengali · Home-style',
      rating: 4.8,
      deliveryTimeMinutes: 25,
      distanceKm: 1.2,
      isOpen: true,
      icon: Icons.dinner_dining_rounded,
      menu: [
        FoodModel(
          id: 'food_1',
          name: 'Chicken Biryani',
          description:
              'Fragrant basmati rice slow-cooked with tender chicken, saffron and home-blended spices.',
          price: 8.99,
          rating: 4.9,
          calories: 620,
          isVeg: false,
          categoryId: 'cat_rice',
          restaurantId: 'rest_1',
          icon: Icons.rice_bowl_rounded,
        ),
        FoodModel(
          id: 'food_2',
          name: 'Beef Curry',
          description: 'Rich, slow-braised beef curry simmered in a traditional spice blend.',
          price: 9.49,
          rating: 4.7,
          calories: 540,
          isVeg: false,
          categoryId: 'cat_rice',
          restaurantId: 'rest_1',
          icon: Icons.set_meal_rounded,
        ),
        FoodModel(
          id: 'food_3',
          name: 'Vegetable Khichuri',
          description: 'Comforting rice and lentil khichuri with mixed seasonal vegetables.',
          price: 6.49,
          rating: 4.5,
          calories: 410,
          isVeg: true,
          categoryId: 'cat_rice',
          restaurantId: 'rest_1',
          icon: Icons.eco_rounded,
        ),
      ],
    ),
    RestaurantModel(
      id: 'rest_2',
      name: 'Nusrat Home Bites',
      cuisine: 'Snacks · Street food',
      rating: 4.6,
      deliveryTimeMinutes: 20,
      distanceKm: 0.8,
      isOpen: true,
      icon: Icons.tapas_rounded,
      menu: [
        FoodModel(
          id: 'food_4',
          name: 'Beef Kebab Roll',
          description: 'Char-grilled beef kebab wrapped in a warm homemade paratha.',
          price: 5.99,
          rating: 4.8,
          calories: 480,
          isVeg: false,
          categoryId: 'cat_snacks',
          restaurantId: 'rest_2',
          icon: Icons.lunch_dining_rounded,
        ),
        FoodModel(
          id: 'food_5',
          name: 'Vegetable Samosa (4pc)',
          description: 'Crispy pastry filled with spiced potatoes, peas and herbs.',
          price: 3.49,
          rating: 4.6,
          calories: 320,
          isVeg: true,
          categoryId: 'cat_snacks',
          restaurantId: 'rest_2',
          icon: Icons.cookie_rounded,
        ),
        FoodModel(
          id: 'food_6',
          name: 'Chicken Fuchka',
          description: 'Crunchy puris filled with tangy tamarind water and spiced chicken.',
          price: 4.29,
          rating: 4.7,
          calories: 280,
          isVeg: false,
          categoryId: 'cat_snacks',
          restaurantId: 'rest_2',
          icon: Icons.tapas_rounded,
        ),
      ],
    ),
    RestaurantModel(
      id: 'rest_3',
      name: 'Rupa Sweets & Bakes',
      cuisine: 'Dessert · Bakery',
      rating: 4.9,
      deliveryTimeMinutes: 30,
      distanceKm: 2.1,
      isOpen: true,
      icon: Icons.cake_rounded,
      menu: [
        FoodModel(
          id: 'food_7',
          name: 'Mishti Doi',
          description: 'Traditional sweetened yogurt, slow-caramelised and chilled.',
          price: 2.99,
          rating: 4.9,
          calories: 210,
          isVeg: true,
          categoryId: 'cat_dessert',
          restaurantId: 'rest_3',
          icon: Icons.icecream_rounded,
        ),
        FoodModel(
          id: 'food_8',
          name: 'Homemade Chocolate Cake',
          description: 'Rich, moist chocolate sponge layered with dark ganache.',
          price: 4.99,
          rating: 4.8,
          calories: 480,
          isVeg: true,
          categoryId: 'cat_bakery',
          restaurantId: 'rest_3',
          icon: Icons.cake_rounded,
        ),
        FoodModel(
          id: 'food_9',
          name: 'Rosogolla (6pc)',
          description: 'Soft cottage-cheese balls soaked in light sugar syrup.',
          price: 3.99,
          rating: 4.7,
          calories: 260,
          isVeg: true,
          categoryId: 'cat_dessert',
          restaurantId: 'rest_3',
          icon: Icons.bakery_dining_rounded,
        ),
      ],
    ),
    RestaurantModel(
      id: 'rest_4',
      name: 'Green Leaf Deli',
      cuisine: 'Healthy · Soups & Salads',
      rating: 4.5,
      deliveryTimeMinutes: 22,
      distanceKm: 1.6,
      isOpen: false,
      icon: Icons.eco_rounded,
      menu: [
        FoodModel(
          id: 'food_10',
          name: 'Chicken Sweet Corn Soup',
          description: 'Hearty soup with shredded chicken, sweet corn and a hint of pepper.',
          price: 4.49,
          rating: 4.6,
          calories: 240,
          isVeg: false,
          categoryId: 'cat_soup',
          restaurantId: 'rest_4',
          icon: Icons.ramen_dining_rounded,
        ),
        FoodModel(
          id: 'food_11',
          name: 'Garden Fresh Salad',
          description: 'Crisp seasonal greens tossed in a light lemon-olive dressing.',
          price: 5.29,
          rating: 4.4,
          calories: 190,
          isVeg: true,
          categoryId: 'cat_soup',
          restaurantId: 'rest_4',
          icon: Icons.eco_rounded,
        ),
      ],
    ),
    RestaurantModel(
      id: 'rest_5',
      name: 'Mocha Corner Cafe',
      cuisine: 'Beverages · Bakery',
      rating: 4.7,
      deliveryTimeMinutes: 18,
      distanceKm: 0.5,
      isOpen: true,
      icon: Icons.local_cafe_rounded,
      menu: [
        FoodModel(
          id: 'food_12',
          name: 'Iced Caramel Latte',
          description: 'Smooth espresso, cold milk and homemade caramel syrup over ice.',
          price: 3.79,
          rating: 4.8,
          calories: 220,
          isVeg: true,
          categoryId: 'cat_drinks',
          restaurantId: 'rest_5',
          icon: Icons.local_cafe_rounded,
        ),
        FoodModel(
          id: 'food_13',
          name: 'Butter Croissant',
          description: 'Flaky, buttery croissant baked fresh every morning.',
          price: 2.49,
          rating: 4.6,
          calories: 310,
          isVeg: true,
          categoryId: 'cat_bakery',
          restaurantId: 'rest_5',
          icon: Icons.bakery_dining_rounded,
        ),
      ],
    ),
  ];

  static List<FoodModel> get allFoods => [for (final r in restaurants) ...r.menu];

  static List<FoodModel> get recommended =>
      (List<FoodModel>.from(allFoods)..sort((a, b) => b.rating.compareTo(a.rating))).take(6).toList();

  static RestaurantModel restaurantById(String id) =>
      restaurants.firstWhere((r) => r.id == id);

  static FoodModel foodById(String id) => allFoods.firstWhere((f) => f.id == id);

  static List<FoodModel> byCategory(String? categoryId) {
    if (categoryId == null) return recommended;
    return allFoods.where((food) => food.categoryId == categoryId).toList();
  }
}
