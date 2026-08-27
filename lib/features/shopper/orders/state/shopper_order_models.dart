enum ShopperOrderStatus { pending, completed, rejected }

class ShopperOrderModel {
  const ShopperOrderModel({
    required this.id,
    required this.emoji,
    required this.storeName,
    required this.itemCount,
    required this.time,
    required this.amount,
    required this.status,
    this.customerName = 'Sarah M.',
    this.deliverTo = 'Downtown Loft',
  });

  final String id;
  final String emoji;
  final String storeName;
  final int itemCount;
  final String time;
  final double amount;
  final ShopperOrderStatus status;
  final String customerName;
  final String deliverTo;
}
