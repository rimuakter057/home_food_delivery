class ShopperProfileDetailModel {
  const ShopperProfileDetailModel({
    required this.name,
    required this.email,
    required this.customerRating,
    required this.orders,
    required this.favorites,
    required this.saved,
  });

  final String name;
  final String email;
  final double customerRating;
  final int orders;
  final int favorites;
  final double saved;
}
