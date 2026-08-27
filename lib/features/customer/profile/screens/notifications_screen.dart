import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../state/profile_mock_data.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final notifications = ProfileMockData.notifications;

    return Scaffold(
      appBar: const CustomAppBar(title: AppStrings.notifications),
      body: SafeArea(
        child: notifications.isEmpty
            ? const EmptyStateWidget(
                icon: Icons.notifications_none_rounded,
                title: AppStrings.noNotificationsTitle,
                subtitle: AppStrings.noNotificationsSubtitle,
              )
            : ListView(
                padding: responsive.padding(all: 16),
                children: notifications
                    .map(
                      (notification) => AppCard(
                        margin: EdgeInsets.only(bottom: responsive.spacing(12)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: responsive.size(40),
                              height: responsive.size(40),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(notification.icon, size: responsive.iconSize(19), color: AppColors.primary),
                            ),
                            SizedBox(width: responsive.spacing(12)),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    notification.title,
                                    style: TextStyle(fontSize: responsive.fontSize(13), fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(height: responsive.spacing(4)),
                                  Text(
                                    notification.message,
                                    style: TextStyle(fontSize: responsive.fontSize(12), color: AppColors.textSecondary),
                                  ),
                                  SizedBox(height: responsive.spacing(6)),
                                  Text(
                                    notification.timeAgo,
                                    style: TextStyle(fontSize: responsive.fontSize(10), color: AppColors.textSecondary),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
      ),
    );
  }
}
