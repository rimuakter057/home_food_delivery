import 'shopper_profile_models.dart';

class ShopperProfileMockData {
  ShopperProfileMockData._();

  static const ShopperProfileDetailModel profile = ShopperProfileDetailModel(
    name: 'John Smith',
    email: 'john.smith@email.com',
    customerRating: 4.9,
    orders: 47,
    favorites: 12,
    saved: 24,
  );
}
