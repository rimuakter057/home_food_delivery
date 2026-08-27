import 'package:flutter/foundation.dart';
import '../../cart/state/cart_state.dart';
import '../../home/state/home_mock_data.dart';
import 'order_models.dart';

/// Holds placed orders for the session. Seeded with a couple of past mock
/// orders so the order history screen has something to show on first run.
class OrdersState extends ChangeNotifier {
  OrdersState() : _orders = _seedOrders();

  final List<OrderModel> _orders;

  List<OrderModel> get orders => List.unmodifiable(_orders.reversed);

  OrderModel orderById(String id) => _orders.firstWhere((order) => order.id == id);

  OrderModel placeOrder({required List<CartItemModel> items, required double total}) {
    final order = OrderModel(
      id: 'ORD${1001 + _orders.length}',
      kitchenName: HomeMockData.restaurantById(items.first.food.restaurantId).name,
      items: items,
      total: total,
      status: OrderStatus.confirmed,
      placedAt: DateTime.now(),
      estimatedDeliveryMinutes: 30,
    );
    _orders.add(order);
    notifyListeners();
    return order;
  }

  static List<OrderModel> _seedOrders() {
    final biryani = HomeMockData.foodById('food_1');
    final samosa = HomeMockData.foodById('food_5');
    final latte = HomeMockData.foodById('food_12');
    final now = DateTime.now();
    return [
      OrderModel(
        id: 'ORD1001',
        kitchenName: HomeMockData.restaurantById('rest_1').name,
        items: [CartItemModel(food: biryani, quantity: 2)],
        total: biryani.price * 2 + CartState.deliveryFee + (biryani.price * 2 * 0.05),
        status: OrderStatus.delivered,
        placedAt: now.subtract(const Duration(days: 3)),
        estimatedDeliveryMinutes: 25,
      ),
      OrderModel(
        id: 'ORD1002',
        kitchenName: HomeMockData.restaurantById('rest_2').name,
        items: [
          CartItemModel(food: samosa, quantity: 1),
          CartItemModel(food: latte, quantity: 1),
        ],
        total: samosa.price + latte.price + CartState.deliveryFee + ((samosa.price + latte.price) * 0.05),
        status: OrderStatus.delivered,
        placedAt: now.subtract(const Duration(days: 1)),
        estimatedDeliveryMinutes: 20,
      ),
    ];
  }
}
