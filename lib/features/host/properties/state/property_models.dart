class RecentOrderModel {
  const RecentOrderModel({required this.customerName, required this.orderId, required this.date, required this.isApproved});

  final String customerName;
  final String orderId;
  final String date;
  final bool isApproved;
}

class PropertyModel {
  const PropertyModel({
    required this.id,
    required this.name,
    required this.type,
    required this.address,
    required this.code,
    required this.activeDeliveries,
    required this.image,
    required this.guestStayDuration,
    required this.deliveryWindow,
    required this.recentOrders,
  });

  final String id;
  final String name;
  final String type;
  final String address;
  final String code;
  final int activeDeliveries;
  final String image;
  final String guestStayDuration;
  final String deliveryWindow;
  final List<RecentOrderModel> recentOrders;
}
