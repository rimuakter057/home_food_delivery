import 'package:flutter/material.dart';
import '../../../../core/constants/app_assets.dart';
import 'host_models.dart';

/// Mock catalog for the Property Host role — mirrors [HomeMockData]'s
/// plain-static-data pattern (no repository layer).
class HostMockData {
  HostMockData._();

  static const HostProfileModel profile = HostProfileModel(
    businessName: 'Sunset Rentals',
    ownerName: 'Johnny Smith',
    email: 'john.smith@email.com',
    phone: '+1 (555) 123-4567',
    memberSince: 'January 2024',
    businessTaxId: '84-1234567',
    businessAddress: '789 Business Ave, Suite 200, Cityville, ST 12345',
  );

  static const HostStatsModel stats = HostStatsModel(
    properties: 4,
    pending: 2,
    upcoming: 5,
    approved: 12,
  );

  static const List<HostActivityModel> recentActivity = [
    HostActivityModel(
      icon: AppAssets.hostActivityOrder,
      iconBackground: Color(0xFFFFF3E0),
      title: 'New order request',
      subtitle: 'John Doe requested delivery for Downtown Apartment',
      timeAgo: '10 m ago',
      amount: '\$45.00',
    ),
    HostActivityModel(
      icon: AppAssets.hostActivityApproved,
      iconBackground: Color(0xFFE3F2FD),
      title: 'Delivery approved',
      subtitle: 'Order #1024 approved for Sunset Villa',
      timeAgo: '10 m ago',
    ),
    HostActivityModel(
      icon: AppAssets.hostActivityCompleted,
      iconBackground: Color(0xFFE8F5E9),
      title: 'Delivery completed',
      subtitle: 'Order #1022 delivered to Ocean View Condo',
      timeAgo: '10 m ago',
    ),
  ];
}
