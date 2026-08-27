import 'package:flutter/material.dart';

class CategoryModel {
  const CategoryModel({required this.id, required this.name, required this.emoji});

  final String id;
  final String name;
  final String emoji;
}

class FoodModel {
  const FoodModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    required this.calories,
    required this.isVeg,
    required this.categoryId,
    required this.restaurantId,
    required this.icon,
  });

  final String id;
  final String name;
  final String description;
  final double price;
  final double rating;
  final int calories;
  final bool isVeg;
  final String categoryId;
  final String restaurantId;
  final IconData icon;
}

class RestaurantModel {
  const RestaurantModel({
    required this.id,
    required this.name,
    required this.cuisine,
    required this.rating,
    required this.deliveryTimeMinutes,
    required this.distanceKm,
    required this.isOpen,
    required this.icon,
    required this.menu,
  });

  final String id;
  final String name;
  final String cuisine;
  final double rating;
  final int deliveryTimeMinutes;
  final double distanceKm;
  final bool isOpen;
  final IconData icon;
  final List<FoodModel> menu;
}

class PromoBannerModel {
  const PromoBannerModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.gradientColors,
  });

  final String id;
  final String title;
  final String subtitle;
  final List<Color> gradientColors;
}
