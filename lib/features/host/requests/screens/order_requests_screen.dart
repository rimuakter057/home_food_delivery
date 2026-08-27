import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../state/request_mock_data.dart';
import '../state/request_models.dart';

/// The Host "Order Requests" list (Figma node 496:12442): a Pending /
/// Scheduled / Delivered tab switcher over per-request summary cards.
class OrderRequestsScreen extends StatefulWidget {
  const OrderRequestsScreen({super.key});

  @override
  State<OrderRequestsScreen> createState() => _OrderRequestsScreenState();
}

class _OrderRequestsScreenState extends State<OrderRequestsScreen> {
  RequestStatus _status = RequestStatus.pending;

  static const _tabs = [
    (status: RequestStatus.pending, label: AppStrings.hostTabPending),
    (status: RequestStatus.scheduled, label: AppStrings.hostTabScheduled),
    (status: RequestStatus.delivered, label: AppStrings.hostTabDelivered),
  ];

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final requests = RequestMockData.byStatus(_status);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: responsive.padding(horizontal: 16, vertical: 8),
              child: Text(AppStrings.hostOrderRequests, style: AppTextStyles.titleLarge, textAlign: TextAlign.center),
            ),
            Padding(
              padding: responsive.padding(horizontal: 16),
              child: Row(
                children: _tabs.map((tab) {
                  final isActive = tab.status == _status;
                  final count = RequestMockData.byStatus(tab.status).length;
                  return Expanded(
                    child: InkWell(
                      onTap: () => setState(() => _status = tab.status),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                tab.label,
                                style: AppTextStyles.labelSmall.copyWith(
                                  color: isActive ? AppColors.primary : AppColors.textSecondary,
                                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: responsive.spacing(8)),
                              Container(
                                width: responsive.size(20),
                                padding: responsive.padding(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: isActive ? const Color(0xFFE8F5E9) : const Color(0xFFF5F5F5),
                                  borderRadius: BorderRadius.circular(responsive.radius(10)),
                                ),
                                child: Text(
                                  '$count',
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.labelSmall.copyWith(
                                    color: isActive ? AppColors.primary : const Color(0xFF848484),
                                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: responsive.spacing(8)),
                          Container(height: 2, color: isActive ? AppColors.primary : Colors.transparent),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            Divider(color: AppColors.textPlaceholder, height: 1),
            Expanded(
              child: requests.isEmpty
                  ? Center(child: Text(AppStrings.hostOrderRequests, style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary)))
                  : ListView.separated(
                      padding: responsive.padding(horizontal: 16, vertical: 16),
                      itemCount: requests.length,
                      separatorBuilder: (_, __) => SizedBox(height: responsive.spacing(12)),
                      itemBuilder: (context, index) => _RequestCard(
                        request: requests[index],
                        onReview: () => context.push(AppRoutes.hostReviewRequestPath(requests[index].id)),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RequestCard extends StatelessWidget {
  const _RequestCard({required this.request, required this.onReview});

  final OrderRequestModel request;
  final VoidCallback onReview;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Container(
      width: double.infinity,
      padding: responsive.padding(all: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(responsive.radius(8)),
        boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: responsive.spacing(4), offset: Offset(0, responsive.spacing(2)))],
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
                  Text(request.customerName, style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold)),
                  Text(request.storeName, style: AppTextStyles.bodySmall),
                ],
              ),
              Text('\$${request.total.toStringAsFixed(2)}', style: AppTextStyles.titleSmall.copyWith(color: AppColors.tealText, fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: responsive.spacing(12)),
          Container(
            width: double.infinity,
            padding: responsive.padding(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(color: const Color(0xFFF5F5F5), border: Border.all(color: AppColors.border, width: 0.5), borderRadius: BorderRadius.circular(responsive.radius(8))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(AppAssets.hostPinTiny, width: responsive.iconSize(14), height: responsive.iconSize(14)),
                    SizedBox(width: responsive.spacing(4)),
                    Text(request.propertyName, style: AppTextStyles.labelSmall.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w500)),
                  ],
                ),
                SizedBox(height: responsive.spacing(6)),
                Row(
                  children: [
                    SvgPicture.asset(AppAssets.hostClockTiny, width: responsive.iconSize(14), height: responsive.iconSize(14)),
                    SizedBox(width: responsive.spacing(4)),
                    Text('Req: ${request.requestedDate.split(',').first}, ${request.requestedWindow.split(' - ').first}', style: AppTextStyles.labelSmall.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w500)),
                  ],
                ),
              ],
            ),
          ),
          if (request.status == RequestStatus.pending) ...[
            SizedBox(height: responsive.spacing(12)),
            Divider(color: AppColors.textPlaceholder, height: 1),
            SizedBox(height: responsive.spacing(12)),
            InkWell(
              onTap: onReview,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppStrings.hostReviewRequest, style: AppTextStyles.labelSmall.copyWith(color: AppColors.tealText, fontWeight: FontWeight.bold)),
                  SvgPicture.asset(AppAssets.hostChevronTeal, width: responsive.iconSize(18), height: responsive.iconSize(18)),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
