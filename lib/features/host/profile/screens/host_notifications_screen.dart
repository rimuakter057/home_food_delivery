import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/pill_toggle_switch.dart';

class _NotificationPref {
  _NotificationPref(this.icon, this.iconBackground, this.label, this.subtitle, this.enabled);
  final String icon;
  final Color iconBackground;
  final String label;
  final String subtitle;
  bool enabled;
}

/// The Host "Notifications" preferences screen (Figma node 521:8195).
class HostNotificationsScreen extends StatefulWidget {
  const HostNotificationsScreen({super.key});

  @override
  State<HostNotificationsScreen> createState() => _HostNotificationsScreenState();
}

class _HostNotificationsScreenState extends State<HostNotificationsScreen> {
  final _prefs = [
    _NotificationPref(AppAssets.hostNotifOrder, const Color(0xFFE8F5E9), 'Order Updates', 'Status changes for your active orders', true),
    _NotificationPref(AppAssets.hostNotifDelivery, const Color(0xFFE3F2FD), 'Delivery Alerts', 'When your dasher is nearby or...', true),
    _NotificationPref(AppAssets.hostNotifPromo, const Color(0xFFFFF8E1), 'Promotions & Deals', 'Discounts, coupons, and special...', true),
    _NotificationPref(AppAssets.hostNotifStore, const Color(0xFFF3E5F5), 'New Stores', 'When new stores open in your area', false),
    _NotificationPref(AppAssets.hostNotifReview, const Color(0xFFFFF8E1), 'Review Reminders', 'Reminders to rate your completed', true),
    _NotificationPref(AppAssets.hostNotifEmail, const Color(0xFFF5F5F5), 'Email Notifications', 'Receive updates via email', false),
    _NotificationPref(AppAssets.hostNotifSms, const Color(0xFFE3F2FD), 'SMS Notifications', 'Receive text message updates', true),
  ];

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: responsive.padding(horizontal: 16, vertical: 8),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () => context.pop(),
                      borderRadius: BorderRadius.circular(responsive.radius(12)),
                      child: SvgPicture.asset(
                        AppAssets.chevronBack,
                        width: responsive.iconSize(24),
                        height: responsive.iconSize(24),
                        colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
                      ),
                    ),
                  ),
                  Text(AppStrings.hostNotifications, style: AppTextStyles.titleLarge),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: responsive.padding(horizontal: 16, vertical: 16),
                children: [
                  Text(
                    "Choose which notifications you'd like to receive.",
                    style: AppTextStyles.bodySmall,
                  ),
                  SizedBox(height: responsive.spacing(12)),
                  for (final pref in _prefs) ...[
                    Container(
                      width: double.infinity,
                      padding: responsive.padding(all: 12),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(responsive.radius(8)),
                        boxShadow: [BoxShadow(color: const Color(0x0F000000), blurRadius: responsive.spacing(4), offset: Offset(0, responsive.spacing(2)))],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: responsive.size(40),
                                  height: responsive.size(40),
                                  decoration: BoxDecoration(color: pref.iconBackground, borderRadius: BorderRadius.circular(responsive.radius(8))),
                                  child: Center(child: SvgPicture.asset(pref.icon, width: responsive.iconSize(18), height: responsive.iconSize(18))),
                                ),
                                SizedBox(width: responsive.spacing(12)),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(pref.label, style: AppTextStyles.titleSmall),
                                      Text(pref.subtitle, style: AppTextStyles.bodySmall),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: responsive.spacing(8)),
                          PillToggleSwitch(
                            value: pref.enabled,
                            onChanged: (value) => setState(() => pref.enabled = value),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: responsive.spacing(12)),
                  ],
                ],
              ),
            ),
            Padding(
              padding: responsive.padding(horizontal: 16, vertical: 16),
              child: AppButton(label: AppStrings.hostSavePreferences, large: true, onPressed: () => context.pop()),
            ),
          ],
        ),
      ),
    );
  }
}
