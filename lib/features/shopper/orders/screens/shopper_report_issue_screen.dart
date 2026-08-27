import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/widgets/app_button.dart';
import '../state/shopper_order_mock_data.dart';

class _IssueReason {
  const _IssueReason(this.emoji, this.title, this.subtitle);
  final String emoji;
  final String title;
  final String subtitle;
}

/// The Shopper "Report an Issue" screen (Figma node 328:4965): a reason
/// picker plus optional free-text details for a problem order.
class ShopperReportIssueScreen extends StatefulWidget {
  const ShopperReportIssueScreen({super.key, required this.orderId});

  final String orderId;

  @override
  State<ShopperReportIssueScreen> createState() => _ShopperReportIssueScreenState();
}

class _ShopperReportIssueScreenState extends State<ShopperReportIssueScreen> {
  final _detailsController = TextEditingController();
  int _selectedReason = -1;

  static const _reasons = [
    _IssueReason('🚪', AppStrings.shopperIssueCustomerNotAvailable, AppStrings.shopperIssueCustomerNotAvailableSubtitle),
    _IssueReason('📍', AppStrings.shopperIssueWrongAddress, AppStrings.shopperIssueWrongAddressSubtitle),
    _IssueReason('📦', AppStrings.shopperIssueItemMissing, AppStrings.shopperIssueItemMissingSubtitle),
    _IssueReason('⚠️', AppStrings.shopperIssueItemDamaged, AppStrings.shopperIssueItemDamagedSubtitle),
    _IssueReason('🚨', AppStrings.shopperIssueEmergency, AppStrings.shopperIssueEmergencySubtitle),
    _IssueReason('💬', AppStrings.shopperIssueOther, AppStrings.shopperIssueOtherSubtitle),
  ];

  @override
  void dispose() {
    _detailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final order = ShopperOrderMockData.byId(widget.orderId);

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
                  Text(AppStrings.shopperReportAnIssue, style: AppTextStyles.titleLarge),
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
                      padding: responsive.padding(all: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF8E1),
                        border: Border.all(color: const Color(0xFFFFE082)),
                        borderRadius: BorderRadius.circular(responsive.radius(8)),
                      ),
                      child: Row(
                        children: [
                          Text('📦', style: TextStyle(fontSize: responsive.fontSize(20))),
                          SizedBox(width: responsive.spacing(12)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Order #${order.id.toUpperCase()}', style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.w600)),
                              Text('${order.storeName} → ${order.customerName}', style: AppTextStyles.bodySmall),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: responsive.spacing(24)),
                    Text(AppStrings.shopperWhatHappened, style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.w600)),
                    SizedBox(height: responsive.spacing(12)),
                    for (var i = 0; i < _reasons.length; i++) ...[
                      _ReasonTile(reason: _reasons[i], isSelected: _selectedReason == i, onTap: () => setState(() => _selectedReason = i)),
                      SizedBox(height: responsive.spacing(12)),
                    ],
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppStrings.shopperAdditionalDetails, style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.w600)),
                        Text(AppStrings.shopperOptional, style: AppTextStyles.labelSmall.copyWith(color: AppColors.textPlaceholder)),
                      ],
                    ),
                    SizedBox(height: responsive.spacing(12)),
                    TextField(
                      controller: _detailsController,
                      maxLines: 4,
                      style: AppTextStyles.bodyMedium,
                      decoration: const InputDecoration(hintText: AppStrings.shopperDescribeWhatHappened),
                    ),
                    SizedBox(height: responsive.spacing(24)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: responsive.padding(horizontal: 16, vertical: 8),
              child: AppButton(label: AppStrings.shopperSubmitReport, onPressed: () => context.pop()),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReasonTile extends StatelessWidget {
  const _ReasonTile({required this.reason, required this.isSelected, required this.onTap});

  final _IssueReason reason;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(responsive.radius(8)),
      child: Container(
        width: double.infinity,
        padding: responsive.padding(all: 12),
        decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(responsive.radius(8))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Text(reason.emoji, style: TextStyle(fontSize: responsive.fontSize(17))),
                  SizedBox(width: responsive.spacing(12)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(reason.title, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w500)),
                        Text(reason.subtitle, style: AppTextStyles.bodySmall),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: responsive.size(20),
              height: responsive.size(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: isSelected ? AppColors.primary : const Color(0xFFBDBDBD), width: 2),
                color: isSelected ? AppColors.primary : Colors.transparent,
              ),
              child: isSelected ? const Icon(Icons.check, size: 14, color: Colors.white) : null,
            ),
          ],
        ),
      ),
    );
  }
}
