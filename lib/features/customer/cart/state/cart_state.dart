import 'package:flutter/foundation.dart';
import '../../home/state/home_models.dart';

class CartItemModel {
  CartItemModel({required this.food, this.quantity = 1});

  final FoodModel food;
  int quantity;

  double get lineTotal => food.price * quantity;
}

/// Holds the shopping cart for the whole app session. Kept as a single
/// ChangeNotifier (provided above MaterialApp) instead of an abstraction
/// layer so screens can read/mutate it directly.
class CartState extends ChangeNotifier {
  final List<CartItemModel> _items = [];

  List<CartItemModel> get items => List.unmodifiable(_items);

  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal => _items.fold(0, (sum, item) => sum + item.lineTotal);

  static const double deliveryFee = 2.99;

  double get taxAmount => subtotal * 0.05;

  double get total => subtotal + (subtotal > 0 ? deliveryFee : 0) + taxAmount;

  bool get isEmpty => _items.isEmpty;

  void addFood(FoodModel food, {int quantity = 1}) {
    final index = _items.indexWhere((item) => item.food.id == food.id);
    if (index >= 0) {
      _items[index].quantity += quantity;
    } else {
      _items.add(CartItemModel(food: food, quantity: quantity));
    }
    notifyListeners();
  }

  void incrementQuantity(String foodId) {
    final index = _items.indexWhere((item) => item.food.id == foodId);
    if (index >= 0) {
      _items[index].quantity++;
      notifyListeners();
    }
  }

  void decrementQuantity(String foodId) {
    final index = _items.indexWhere((item) => item.food.id == foodId);
    if (index >= 0 && _items[index].quantity > 1) {
      _items[index].quantity--;
      notifyListeners();
    }
  }

  void removeItem(String foodId) {
    _items.removeWhere((item) => item.food.id == foodId);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
