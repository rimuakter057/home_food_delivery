import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_helper.dart';

/// The Shopper "Withdrawal Requested!" confirmation (Figma node 294:5612).
class ShopperWithdrawalRequestedScreen extends StatelessWidget {
  const ShopperWithdrawalRequestedScreen({super.key, this.amount = 100.00});

  final double amount;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: responsive.padding(horizontal: 16),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: responsive.padding(vertical: 8),
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
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: responsive.size(108),
                        height: responsive.size(108),
                        decoration: const BoxDecoration(color: Color(0x3D2E7D32), shape: BoxShape.circle),
                        child: Center(
                          child: SvgPicture.asset(AppAssets.shopperWithdrawalCheck, width: responsive.iconSize(78.5), height: responsive.iconSize(78.5)),
                        ),
                      ),
                      SizedBox(height: responsive.spacing(24)),
                      Text(AppStrings.shopperWithdrawalRequestedTitle, style: AppTextStyles.titleSmall.copyWith(fontSize: 24, height: 32 / 24)),
                      SizedBox(height: responsive.spacing(12)),
                      Text(
                        '\$${amount.toStringAsFixed(2)} sent to your bank',
                        style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary),
                      ),
                      SizedBox(height: responsive.spacing(12)),
                      Text(
                        AppStrings.shopperWithdrawalPendingSubtitle,
                        style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
