import 'package:flutter/material.dart';

class UserModel {
  const UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.avatarColor,
    required this.memberSince,
    required this.deliveryAddress,
  });

  final String name;
  final String email;
  final String phone;
  final Color avatarColor;
  final String memberSince;
  final String deliveryAddress;
}

class AddressModel {
  const AddressModel({
    required this.id,
    required this.label,
    required this.fullAddress,
    required this.isDefault,
  });

  final String id;
  final String label;
  final String fullAddress;
  final bool isDefault;
}

class PaymentMethodModel {
  const PaymentMethodModel({
    required this.id,
    required this.label,
    required this.subtitle,
    required this.icon,
    required this.isDefault,
  });

  final String id;
  final String label;
  final String subtitle;
  final IconData icon;
  final bool isDefault;
}

class ProfileMenuItemModel {
  const ProfileMenuItemModel({required this.icon, required this.label});

  final IconData icon;
  final String label;
}

class NotificationModel {
  const NotificationModel({
    required this.icon,
    required this.title,
    required this.message,
    required this.timeAgo,
  });

  final IconData icon;
  final String title;
  final String message;
  final String timeAgo;
}
