import 'package:flutter/material.dart';

class ShopperProfileModel {
  const ShopperProfileModel({required this.name});

  final String name;
}

class ShopperStatsModel {
  const ShopperStatsModel({
    required this.today,
    required this.deliveries,
    required this.rating,
    required this.thisWeekEarnings,
    required this.thisWeekChangeLabel,
    required this.totalOrders,
  });

  final double today;
  final int deliveries;
  final double rating;
  final double thisWeekEarnings;
  final String thisWeekChangeLabel;
  final int totalOrders;
}

class ShopperActiveOrderModel {
  const ShopperActiveOrderModel({
    required this.emoji,
    required this.storeName,
    required this.recipient,
    required this.itemCount,
    required this.statusLabel,
    required this.statusBackground,
    required this.statusColor,
  });

  final String emoji;
  final String storeName;
  final String recipient;
  final int itemCount;
  final String statusLabel;
  final Color statusBackground;
  final Color statusColor;
}

class ShopperPendingRequestModel {
  const ShopperPendingRequestModel({
    required this.emoji,
    required this.storeName,
    required this.itemCount,
    required this.time,
    required this.amount,
  });

  final String emoji;
  final String storeName;
  final int itemCount;
  final String time;
  final double amount;
}

class ShopperRecentDeliveryModel {
  const ShopperRecentDeliveryModel({
    required this.image,
    required this.storeName,
    required this.recipient,
    required this.timeAgo,
    required this.amount,
    required this.rating,
  });

  final String image;
  final String storeName;
  final String recipient;
  final String timeAgo;
  final double amount;
  final double rating;
}
