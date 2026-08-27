import 'package:flutter/material.dart';

class HostStatsModel {
  const HostStatsModel({
    required this.properties,
    required this.pending,
    required this.upcoming,
    required this.approved,
  });

  final int properties;
  final int pending;
  final int upcoming;
  final int approved;
}

class HostActivityModel {
  const HostActivityModel({
    required this.icon,
    required this.iconBackground,
    required this.title,
    required this.subtitle,
    required this.timeAgo,
    this.amount,
  });

  final String icon;
  final Color iconBackground;
  final String title;
  final String subtitle;
  final String timeAgo;
  final String? amount;
}

class HostProfileModel {
  const HostProfileModel({
    required this.businessName,
    required this.ownerName,
    required this.email,
    required this.phone,
    required this.memberSince,
    this.businessTaxId = '',
    this.businessAddress = '',
  });

  final String businessName;
  final String ownerName;
  final String email;
  final String phone;
  final String memberSince;
  final String businessTaxId;
  final String businessAddress;
}
