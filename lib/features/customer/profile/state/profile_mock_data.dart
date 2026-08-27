import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import 'profile_models.dart';

class ProfileMockData {
  ProfileMockData._();

  static const UserModel currentUser = UserModel(
    name: 'Ariana Rahman',
    email: 'ariana.rahman@example.com',
    phone: '+1 555 204 7788',
    avatarColor: AppColors.primary,
    memberSince: 'March 2023',
    deliveryAddress: '48 Willow Street, Apt 5B, Riverside',
  );

  static const List<AddressModel> addresses = [
    AddressModel(
      id: 'addr_1',
      label: 'Home',
      fullAddress: '48 Willow Street, Apt 5B, Riverside',
      isDefault: true,
    ),
    AddressModel(
      id: 'addr_2',
      label: 'Office',
      fullAddress: '120 Maple Avenue, Suite 300, Downtown',
      isDefault: false,
    ),
  ];

  static const List<PaymentMethodModel> paymentMethods = [
    PaymentMethodModel(
      id: 'pay_1',
      label: 'Visa •••• 4821',
      subtitle: 'Expires 08/27',
      icon: Icons.credit_card_rounded,
      isDefault: true,
    ),
    PaymentMethodModel(
      id: 'pay_2',
      label: 'Cash on Delivery',
      subtitle: 'Pay when your food arrives',
      icon: Icons.payments_rounded,
      isDefault: false,
    ),
  ];

  static const List<NotificationModel> notifications = [
    NotificationModel(
      icon: Icons.delivery_dining_rounded,
      title: 'Your order is on the way',
      message: 'Amara\'s Kitchen just handed your order to the rider.',
      timeAgo: '10 min ago',
    ),
    NotificationModel(
      icon: Icons.local_offer_rounded,
      title: '30% off your next order',
      message: 'Use code HOME30 before it expires this weekend.',
      timeAgo: '2 hr ago',
    ),
    NotificationModel(
      icon: Icons.star_rounded,
      title: 'Rate your last order',
      message: 'Tell us how Rupa Sweets & Bakes did on your last delivery.',
      timeAgo: '1 day ago',
    ),
  ];

  static const List<ProfileMenuItemModel> menuItems = [
    ProfileMenuItemModel(icon: Icons.receipt_long_rounded, label: 'My Orders'),
    ProfileMenuItemModel(icon: Icons.location_on_outlined, label: 'My Addresses'),
    ProfileMenuItemModel(icon: Icons.credit_card_rounded, label: 'Payment Methods'),
    ProfileMenuItemModel(icon: Icons.favorite_border_rounded, label: 'Favorites'),
    ProfileMenuItemModel(icon: Icons.notifications_none_rounded, label: 'Notifications'),
    ProfileMenuItemModel(icon: Icons.privacy_tip_outlined, label: 'Privacy & Security'),
    ProfileMenuItemModel(icon: Icons.help_outline_rounded, label: 'Help & Support'),
  ];
}
