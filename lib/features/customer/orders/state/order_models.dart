import '../../cart/state/cart_state.dart';

enum OrderStatus { placed, confirmed, preparing, onTheWay, delivered }

class OrderModel {
  const OrderModel({
    required this.id,
    required this.kitchenName,
    required this.items,
    required this.total,
    required this.status,
    required this.placedAt,
    required this.estimatedDeliveryMinutes,
  });

  final String id;
  final String kitchenName;
  final List<CartItemModel> items;
  final double total;
  final OrderStatus status;
  final DateTime placedAt;
  final int estimatedDeliveryMinutes;

  int get totalItemCount => items.fold(0, (sum, item) => sum + item.quantity);
}
