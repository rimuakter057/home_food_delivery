import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../navigation/state/host_navigation_state.dart';
import '../state/host_mock_data.dart';
import '../state/host_models.dart';

/// The Property Host dashboard (Figma node 494:10592): stats, quick
/// actions, and a recent-activity feed for the currently signed-in host.
class HostDashboardScreen extends StatelessWidget {
  const HostDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final profile = HostMockData.profile;
    final stats = HostMockData.stats;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              width: double.infinity,
              padding: responsive.padding(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: AppColors.primaryDark,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(responsive.radius(24)),
                  bottomRight: Radius.circular(responsive.radius(24)),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.hostGoodMorning,
                            style: AppTextStyles.bodyMedium.copyWith(color: Colors.white, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            profile.businessName,
                            style: AppTextStyles.titleSmall.copyWith(color: Colors.white, fontSize: 16, height: 20 / 16),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                width: responsive.size(36),
                                height: responsive.size(36),
                                decoration: const BoxDecoration(color: Color(0xFFF5F5F5), shape: BoxShape.circle),
                                child: Center(
                                  child: SvgPicture.asset(AppAssets.hostBell, width: responsive.iconSize(18), height: responsive.iconSize(18)),
                                ),
                              ),
                              Positioned(
                                right: -responsive.spacing(2),
                                top: -responsive.spacing(2),
                                child: Container(
                                  padding: responsive.padding(all: 3),
                                  constraints: BoxConstraints(minWidth: responsive.size(16), minHeight: responsive.size(16)),
                                  decoration: const BoxDecoration(color: AppColors.error, shape: BoxShape.circle),
                                  child: Text(
                                    '2',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white, fontSize: responsive.fontSize(9), fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: responsive.spacing(10)),
                          Container(
                            width: responsive.size(36),
                            height: responsive.size(36),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(color: const Color(0x4D2E7D32), blurRadius: responsive.spacing(8), offset: Offset(0, responsive.spacing(2))),
                              ],
                            ),
                            child: ClipOval(
                              child: Image.asset(AppAssets.hostAvatar, fit: BoxFit.cover),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: responsive.spacing(24)),
                  Row(
                    children: [
                      Expanded(child: _StatCard(icon: AppAssets.hostStatProperties, label: AppStrings.hostStatProperties, value: stats.properties)),
                      SizedBox(width: responsive.spacing(12)),
                      Expanded(child: _StatCard(icon: AppAssets.hostStatPending, label: AppStrings.hostStatPending, value: stats.pending)),
                    ],
                  ),
                  SizedBox(height: responsive.spacing(12)),
                  Row(
                    children: [
                      Expanded(child: _StatCard(icon: AppAssets.hostStatUpcoming, label: AppStrings.hostStatUpcoming, value: stats.upcoming)),
                      SizedBox(width: responsive.spacing(12)),
                      Expanded(child: _StatCard(icon: AppAssets.hostStatApproved, label: AppStrings.hostStatApproved, value: stats.approved)),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: responsive.padding(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppStrings.hostQuickActions, style: AppTextStyles.titleSmall),
                  SizedBox(height: responsive.spacing(12)),
                  Row(
                    children: [
                      Expanded(
                        child: _QuickAction(
                          icon: AppAssets.hostActionAdd,
                          background: const Color(0xFFE0F2F1),
                          label: AppStrings.hostAddProperty,
                          onTap: () => context.push(AppRoutes.hostAddProperty),
                        ),
                      ),
                      SizedBox(width: responsive.spacing(12)),
                      Expanded(
                        child: _QuickAction(
                          icon: AppAssets.hostActionRequests,
                          background: const Color(0xFFE3F2FD),
                          label: AppStrings.hostViewRequests,
                          onTap: () => context.read<HostNavigationState>().setIndex(2),
                        ),
                      ),
                      SizedBox(width: responsive.spacing(12)),
                      Expanded(
                        child: _QuickAction(
                          icon: AppAssets.hostActionShare,
                          background: const Color(0xFFF3E5F5),
                          label: AppStrings.hostShareCode,
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: responsive.spacing(20)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppStrings.hostRecentActivity, style: AppTextStyles.titleSmall),
                      Text(
                        AppStrings.hostViewAll,
                        style: AppTextStyles.labelSmall.copyWith(color: AppColors.tealText, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(height: responsive.spacing(12)),
                  ...HostMockData.recentActivity.map(
                    (activity) => Padding(
                      padding: EdgeInsets.only(bottom: responsive.spacing(12)),
                      child: _ActivityTile(activity: activity),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.icon, required this.label, required this.value});

  final String icon;
  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Container(
      width: double.infinity,
      padding: responsive.padding(horizontal: 24, vertical: 17),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(responsive.radius(8)),
        boxShadow: [
          BoxShadow(color: AppColors.cardShadow, blurRadius: responsive.spacing(4), offset: Offset(0, responsive.spacing(2))),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(icon, width: responsive.iconSize(18), height: responsive.iconSize(18)),
              SizedBox(width: responsive.spacing(6)),
              Text(label, style: AppTextStyles.bodySmall),
            ],
          ),
          SizedBox(height: responsive.spacing(4)),
          Text(value.toString().padLeft(2, '0'), style: AppTextStyles.numberLarge),
        ],
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({required this.icon, required this.background, required this.label, required this.onTap});

  final String icon;
  final Color background;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(responsive.radius(8)),
      child: Container(
        padding: responsive.padding(all: 12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(responsive.radius(8)),
          boxShadow: [
            BoxShadow(color: AppColors.cardShadow, blurRadius: responsive.spacing(4), offset: Offset(0, responsive.spacing(2))),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: responsive.size(48),
              height: responsive.size(48),
              decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(responsive.radius(8))),
              child: Center(child: SvgPicture.asset(icon, width: responsive.iconSize(24), height: responsive.iconSize(24))),
            ),
            SizedBox(height: responsive.spacing(12)),
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.bodySmall.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActivityTile extends StatelessWidget {
  const _ActivityTile({required this.activity});

  final HostActivityModel activity;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Container(
      width: double.infinity,
      padding: responsive.padding(all: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(responsive.radius(8)),
        boxShadow: [
          BoxShadow(color: const Color(0x0F000000), blurRadius: responsive.spacing(8), offset: Offset(0, responsive.spacing(2))),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: responsive.size(40),
            height: responsive.size(40),
            decoration: BoxDecoration(color: activity.iconBackground, borderRadius: BorderRadius.circular(responsive.radius(8))),
            child: Center(child: SvgPicture.asset(activity.icon, width: responsive.iconSize(20), height: responsive.iconSize(20))),
          ),
          SizedBox(width: responsive.spacing(12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(activity.title, style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold)),
                SizedBox(height: responsive.spacing(4)),
                Text(activity.subtitle, style: AppTextStyles.bodySmall),
              ],
            ),
          ),
          SizedBox(width: responsive.spacing(8)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (activity.amount != null)
                Text(activity.amount!, style: AppTextStyles.titleSmall.copyWith(color: AppColors.tealText, fontWeight: FontWeight.bold)),
              SizedBox(height: responsive.spacing(4)),
              Text(activity.timeAgo, style: AppTextStyles.bodySmall),
            ],
          ),
        ],
      ),
    );
  }
}
