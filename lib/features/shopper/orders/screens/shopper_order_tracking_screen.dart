import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../state/shopper_order_mock_data.dart';

/// The Shopper order tracking screen (Figma nodes 234:12199 collapsed /
/// 304:6109 expanded): a static map with a pickup marker, plus a bottom
/// sheet that toggles between a progress-dots summary and the full
/// step-by-step checklist.
class ShopperOrderTrackingScreen extends StatefulWidget {
  const ShopperOrderTrackingScreen({super.key, required this.orderId});

  final String orderId;

  @override
  State<ShopperOrderTrackingScreen> createState() => _ShopperOrderTrackingScreenState();
}

class _ShopperOrderTrackingScreenState extends State<ShopperOrderTrackingScreen> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final order = ShopperOrderMockData.byId(widget.orderId);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Positioned.fill(child: Image.asset(AppAssets.mapStatic, fit: BoxFit.cover)),
          Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: responsive.spacing(120)),
              child: Container(
                width: responsive.size(41),
                height: responsive.size(41),
                decoration: BoxDecoration(
                  color: const Color(0xFF1565C0),
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: const Color(0x991565C0), blurRadius: responsive.spacing(6), offset: Offset(0, responsive.spacing(2)))],
                ),
                child: Center(child: Text('🚴', style: TextStyle(fontSize: responsive.fontSize(12)))),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: responsive.padding(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => context.pop(),
                    borderRadius: BorderRadius.circular(responsive.radius(12)),
                    child: SvgPicture.asset(AppAssets.chevronBack, width: responsive.iconSize(24), height: responsive.iconSize(24)),
                  ),
                  Container(
                    padding: responsive.padding(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.9), borderRadius: BorderRadius.circular(responsive.radius(8))),
                    child: Text('Order #${order.id.toUpperCase()}', style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w500)),
                  ),
                  InkWell(
                    onTap: () => context.push(AppRoutes.shopperReportIssuePath(order.id)),
                    borderRadius: BorderRadius.circular(responsive.radius(8)),
                    child: Container(
                      padding: responsive.padding(horizontal: 12, vertical: 7),
                      decoration: BoxDecoration(color: const Color(0x1AD32F2F), borderRadius: BorderRadius.circular(responsive.radius(8))),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.warning_amber_rounded, size: responsive.iconSize(12), color: AppColors.error),
                          SizedBox(width: responsive.spacing(4)),
                          Text(AppStrings.shopperIssue, style: AppTextStyles.bodySmall.copyWith(color: AppColors.error, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: responsive.spacing(69) + MediaQuery.of(context).padding.top,
            left: 0,
            right: 0,
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(AppAssets.shopperStatusIcon, width: responsive.iconSize(14), height: responsive.iconSize(14)),
                  SizedBox(width: responsive.spacing(4)),
                  Text(AppStrings.shopperPickingUp, style: AppTextStyles.bodySmall.copyWith(color: AppColors.ratingStar, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              padding: responsive.padding(horizontal: 30).copyWith(top: responsive.spacing(12), bottom: responsive.spacing(24)),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.vertical(top: Radius.circular(responsive.radius(24))),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      ClipOval(child: Image.asset(AppAssets.hostAvatar, width: responsive.size(42), height: responsive.size(42), fit: BoxFit.cover)),
                      SizedBox(width: responsive.spacing(12)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(order.storeName, style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold)),
                            Text(AppStrings.shopperTravelHint, style: AppTextStyles.bodySmall),
                          ],
                        ),
                      ),
                      _CircleIconButton(background: AppColors.infoBadgeBackground, icon: AppAssets.shopperMessageIcon, onTap: () {}),
                      SizedBox(width: responsive.spacing(12)),
                      _CircleIconButton(background: const Color(0xFFE8F5E9), icon: AppAssets.shopperCallIcon, onTap: () {}),
                    ],
                  ),
                  Padding(padding: responsive.padding(vertical: 12), child: Divider(color: const Color(0xFFF5F5F5), height: 1)),
                  if (!_expanded) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppStrings.shopperConfirmPickupWithStore, style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.w600)),
                        InkWell(
                          onTap: () => setState(() => _expanded = true),
                          child: Icon(Icons.keyboard_arrow_up_rounded, size: responsive.iconSize(20), color: AppColors.textPrimary),
                        ),
                      ],
                    ),
                    SizedBox(height: responsive.spacing(12)),
                    Row(
                      children: List.generate(5, (index) {
                        final filled = index < 3;
                        return Expanded(
                          child: Container(
                            margin: EdgeInsets.only(right: index == 4 ? 0 : responsive.spacing(4)),
                            height: responsive.size(6),
                            decoration: BoxDecoration(
                              color: filled ? AppColors.primary : const Color(0xFFE0E0E0),
                              borderRadius: BorderRadius.circular(responsive.radius(9999)),
                            ),
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: responsive.spacing(16)),
                    InkWell(
                      onTap: () => context.pop(),
                      child: Text(
                        AppStrings.shopperBackToHome,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.labelSmall.copyWith(color: AppColors.textSecondary, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ] else ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () => setState(() => _expanded = false),
                          child: Icon(Icons.keyboard_arrow_down_rounded, size: responsive.iconSize(20), color: AppColors.textPrimary),
                        ),
                      ],
                    ),
                    _TrackingStep(icon: AppAssets.shopperStepTravel, title: '${AppStrings.shopperHeadToStore} ${order.storeName}', subtitle: AppStrings.shopperTravelHint, showLine: true),
                    _TrackingStep(icon: AppAssets.shopperStepCollect, title: '${AppStrings.shopperCollectItems} ${order.itemCount} ${AppStrings.shopperItemsSuffix}', subtitle: AppStrings.shopperCheckListCarefully, showLine: true),
                    _TrackingStep(icon: AppAssets.shopperStepConfirm, title: AppStrings.shopperConfirmPickupWithStore, subtitle: AppStrings.shopperScanQrOrTapConfirm, showLine: false),
                    SizedBox(height: responsive.spacing(20)),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => context.pop(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: responsive.padding(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(responsive.radius(8))),
                        ),
                        child: Text(AppStrings.shopperCompleteOrder, style: AppTextStyles.buttonLabel),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({required this.background, required this.icon, required this.onTap});

  final Color background;
  final String icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(responsive.radius(9999)),
      child: Container(
        width: responsive.size(38),
        height: responsive.size(38),
        decoration: BoxDecoration(color: background, shape: BoxShape.circle),
        child: Center(child: SvgPicture.asset(icon, width: responsive.iconSize(15), height: responsive.iconSize(15))),
      ),
    );
  }
}

class _TrackingStep extends StatelessWidget {
  const _TrackingStep({required this.icon, required this.title, required this.subtitle, required this.showLine});

  final String icon;
  final String title;
  final String subtitle;
  final bool showLine;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Padding(
      padding: EdgeInsets.only(top: responsive.spacing(12)),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: responsive.size(28),
                  height: responsive.size(28),
                  decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                  child: Center(child: SvgPicture.asset(icon, width: responsive.iconSize(14), height: responsive.iconSize(14))),
                ),
                if (showLine) Expanded(child: Container(width: 2, color: AppColors.primary)),
              ],
            ),
            SizedBox(width: responsive.spacing(12)),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: responsive.spacing(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w500)),
                    Text(subtitle, style: AppTextStyles.bodySmall),
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
