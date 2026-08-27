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

/// The "Review Request" screen (Figma node 517:6337): customer/store info,
/// requested delivery window, the order's line items, and Reject / Approve.
class ReviewRequestScreen extends StatelessWidget {
  const ReviewRequestScreen({super.key, required this.requestId});

  final String requestId;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final request = RequestMockData.byId(requestId);

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
                  Text(AppStrings.hostReviewRequest, style: AppTextStyles.titleLarge),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: responsive.padding(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: responsive.padding(all: 20),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        border: Border.all(color: AppColors.divider),
                        borderRadius: BorderRadius.circular(responsive.radius(8)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(AppStrings.hostCustomer, style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.bold)),
                                  Text(request.customerName, style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold, fontSize: 14)),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(AppStrings.hostStore, style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.bold)),
                                  Text(request.storeName, style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold, fontSize: 14)),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: responsive.spacing(16)),
                          Divider(color: AppColors.divider, height: 1),
                          SizedBox(height: responsive.spacing(16)),
                          Text(AppStrings.hostDeliveryTo, style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.bold)),
                          SizedBox(height: responsive.spacing(8)),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(AppAssets.locationPinSmall, width: responsive.iconSize(16), height: responsive.iconSize(16), colorFilter: const ColorFilter.mode(AppColors.tealText, BlendMode.srcIn)),
                              SizedBox(width: responsive.spacing(8)),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(request.propertyName, style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold, fontSize: 14)),
                                  Text(request.propertyAddress, style: AppTextStyles.bodySmall),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: responsive.spacing(16)),
                    Container(
                      width: double.infinity,
                      padding: responsive.padding(all: 24),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.12),
                        border: Border.all(color: const Color(0xFFB2DFDB)),
                        borderRadius: BorderRadius.circular(responsive.radius(8)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(AppAssets.hostClockTeal, width: responsive.iconSize(20), height: responsive.iconSize(20)),
                          SizedBox(width: responsive.spacing(12)),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(AppStrings.hostRequestedDeliveryWindow, style: AppTextStyles.labelSmall.copyWith(color: AppColors.tealText, fontWeight: FontWeight.w500)),
                                Text(request.requestedDate, style: AppTextStyles.titleSmall.copyWith(fontSize: 16, height: 28 / 16)),
                                Text(request.requestedWindow, style: AppTextStyles.bodySmall.copyWith(color: AppColors.tealText)),
                                SizedBox(height: responsive.spacing(16)),
                                Container(
                                  width: double.infinity,
                                  padding: responsive.padding(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.5), borderRadius: BorderRadius.circular(responsive.radius(4))),
                                  child: Text(AppStrings.hostMatchesDeliveryRules, style: AppTextStyles.bodySmall.copyWith(color: const Color(0xFF004D40))),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: responsive.spacing(16)),
                    Container(
                      width: double.infinity,
                      padding: responsive.padding(all: 24),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        border: Border.all(color: AppColors.divider),
                        borderRadius: BorderRadius.circular(responsive.radius(8)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(AppAssets.hostBagIcon, width: responsive.iconSize(18), height: responsive.iconSize(18)),
                              SizedBox(width: responsive.spacing(8)),
                              Text('${AppStrings.hostOrderItems} (${request.items.length})', style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          SizedBox(height: responsive.spacing(16)),
                          ...request.items.map(
                            (item) => Padding(
                              padding: EdgeInsets.only(bottom: responsive.spacing(8)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      style: AppTextStyles.bodySmall,
                                      children: [
                                        TextSpan(text: '${item.quantity}x  '),
                                        TextSpan(text: item.name, style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w500)),
                                      ],
                                    ),
                                  ),
                                  Text('\$${item.price.toStringAsFixed(2)}', style: AppTextStyles.bodySmall.copyWith(color: AppColors.textPrimary)),
                                ],
                              ),
                            ),
                          ),
                          Divider(color: AppColors.divider, height: responsive.spacing(24)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(AppStrings.hostTotal, style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold, fontSize: 16, height: 24 / 16)),
                              Text(
                                '\$${request.total.toStringAsFixed(2)}',
                                style: AppTextStyles.titleSmall.copyWith(color: AppColors.tealText, fontWeight: FontWeight.normal, fontSize: 16, height: 28 / 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: responsive.spacing(20)),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => context.pop(),
                            style: OutlinedButton.styleFrom(
                              backgroundColor: const Color(0xFFFFEBEE),
                              side: BorderSide.none,
                              padding: responsive.padding(vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(responsive.radius(8))),
                            ),
                            child: Text(AppStrings.hostReject, style: AppTextStyles.buttonLabelLarge.copyWith(color: AppColors.error)),
                          ),
                        ),
                        SizedBox(width: responsive.spacing(10)),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => context.push(AppRoutes.hostDeliveryWindowPath(requestId)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              padding: responsive.padding(vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(responsive.radius(8))),
                            ),
                            child: Text(AppStrings.hostApproveDelivery, style: AppTextStyles.buttonLabelLarge),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: responsive.spacing(16)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
