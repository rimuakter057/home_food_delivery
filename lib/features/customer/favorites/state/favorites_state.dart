import 'package:flutter/foundation.dart';
import '../../home/state/home_models.dart';

class FavoritesState extends ChangeNotifier {
  final List<FoodModel> _favorites = [];

  List<FoodModel> get favorites => List.unmodifiable(_favorites);

  bool isFavorite(String foodId) => _favorites.any((food) => food.id == foodId);

  void toggleFavorite(FoodModel food) {
    if (isFavorite(food.id)) {
      _favorites.removeWhere((item) => item.id == food.id);
    } else {
      _favorites.add(food);
    }
    notifyListeners();
  }
}
