import 'shopper_order_models.dart';

class ShopperOrderMockData {
  ShopperOrderMockData._();

  static const List<ShopperOrderModel> orders = [
    ShopperOrderModel(id: 'ff_2847', emoji: '🌿', storeName: 'Metro Grocers', itemCount: 5, time: '02:15 PM', amount: 11.00, status: ShopperOrderStatus.pending),
    ShopperOrderModel(id: 'ord_2', emoji: '🌿', storeName: 'Metro Grocers', itemCount: 5, time: '02:15 PM', amount: 11.00, status: ShopperOrderStatus.pending),
    ShopperOrderModel(id: 'ord_3', emoji: '🌿', storeName: 'Metro Grocers', itemCount: 5, time: '02:15 PM', amount: 11.00, status: ShopperOrderStatus.completed),
    ShopperOrderModel(id: 'ord_4', emoji: '🌿', storeName: 'Metro Grocers', itemCount: 5, time: '02:15 PM', amount: 11.00, status: ShopperOrderStatus.completed),
    ShopperOrderModel(id: 'ord_5', emoji: '🌿', storeName: 'Metro Grocers', itemCount: 5, time: '02:15 PM', amount: 11.00, status: ShopperOrderStatus.completed),
    ShopperOrderModel(id: 'ord_6', emoji: '🌿', storeName: 'Metro Grocers', itemCount: 5, time: '02:15 PM', amount: 11.00, status: ShopperOrderStatus.rejected),
    ShopperOrderModel(id: 'ord_7', emoji: '🌿', storeName: 'Metro Grocers', itemCount: 5, time: '02:15 PM', amount: 11.00, status: ShopperOrderStatus.rejected),
  ];

  static ShopperOrderModel byId(String id) => orders.firstWhere((order) => order.id == id, orElse: () => orders.first);

  static List<ShopperOrderModel> byStatus(ShopperOrderStatus status) => orders.where((order) => order.status == status).toList();
}
