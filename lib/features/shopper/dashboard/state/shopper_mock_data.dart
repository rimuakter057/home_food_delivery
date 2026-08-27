import 'package:flutter/material.dart';
import '../../../../core/constants/app_assets.dart';
import 'shopper_models.dart';

/// Mock catalog for the Shopper (dasher) role — mirrors [HostMockData]'s
/// plain-static-data pattern (no repository layer).
class ShopperMockData {
  ShopperMockData._();

  static const ShopperProfileModel profile = ShopperProfileModel(name: 'Marcus');

  static const ShopperStatsModel stats = ShopperStatsModel(
    today: 47.50,
    deliveries: 6,
    rating: 4.97,
    thisWeekEarnings: 284.50,
    thisWeekChangeLabel: '+12% vs last week',
    totalOrders: 1240,
  );

  static const List<ShopperPendingRequestModel> pendingRequests = [
    ShopperPendingRequestModel(emoji: '🌿', storeName: 'Metro Grocers', itemCount: 5, time: '02:15 PM', amount: 11.00),
    ShopperPendingRequestModel(emoji: '🌿', storeName: 'Metro Grocers', itemCount: 5, time: '02:15 PM', amount: 11.00),
  ];

  static const List<ShopperActiveOrderModel> activeOrders = [
    ShopperActiveOrderModel(
      emoji: '🌿',
      storeName: 'Green Valley',
      recipient: 'To Emma',
      itemCount: 4,
      statusLabel: 'Picking up',
      statusBackground: Color(0xFFFFF8E1),
      statusColor: Color(0xFFF57C00),
    ),
    ShopperActiveOrderModel(
      emoji: '🏪',
      storeName: 'City Supermart',
      recipient: 'To Ryan B',
      itemCount: 7,
      statusLabel: 'Delivering',
      statusBackground: Color(0xFFE3F2FD),
      statusColor: Color(0xFF1565C0),
    ),
  ];

  static const List<ShopperRecentDeliveryModel> recentDeliveries = [
    ShopperRecentDeliveryModel(
      image: AppAssets.storeThumbFreshProduce,
      storeName: 'Fresh Farms Co.',
      recipient: 'To Ryan B',
      timeAgo: '2h ago',
      amount: 8.50,
      rating: 4.9,
    ),
    ShopperRecentDeliveryModel(
      image: AppAssets.storeThumbFreshProduce,
      storeName: 'Fresh Farms Co.',
      recipient: 'To Ryan B',
      timeAgo: '2h ago',
      amount: 8.50,
      rating: 4.9,
    ),
    ShopperRecentDeliveryModel(
      image: AppAssets.storeThumbFreshProduce,
      storeName: 'Fresh Farms Co.',
      recipient: 'To Ryan B',
      timeAgo: '2h ago',
      amount: 8.50,
      rating: 4.9,
    ),
  ];
}
