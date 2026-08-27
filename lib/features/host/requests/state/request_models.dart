enum RequestStatus { pending, scheduled, delivered }

class OrderItemModel {
  const OrderItemModel({required this.quantity, required this.name, required this.price});

  final int quantity;
  final String name;
  final double price;
}

class OrderRequestModel {
  const OrderRequestModel({
    required this.id,
    required this.customerName,
    required this.storeName,
    required this.total,
    required this.propertyName,
    required this.propertyAddress,
    required this.requestedDate,
    required this.requestedWindow,
    required this.status,
    required this.items,
  });

  final String id;
  final String customerName;
  final String storeName;
  final double total;
  final String propertyName;
  final String propertyAddress;
  final String requestedDate;
  final String requestedWindow;
  final RequestStatus status;
  final List<OrderItemModel> items;
}
