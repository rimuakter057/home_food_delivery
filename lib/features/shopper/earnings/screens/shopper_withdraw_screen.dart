import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/widgets/app_button.dart';
import '../state/shopper_earnings_mock_data.dart';

/// The Shopper "Withdraw Earnings" screen (Figma node 294:4487): an amount
/// input with quick-pick chips, and a linked-bank-account picker.
class ShopperWithdrawScreen extends StatefulWidget {
  const ShopperWithdrawScreen({super.key});

  @override
  State<ShopperWithdrawScreen> createState() => _ShopperWithdrawScreenState();
}

class _ShopperWithdrawScreenState extends State<ShopperWithdrawScreen> {
  final _amountController = TextEditingController();
  int _selectedAccount = 0;

  static const _quickAmounts = ['\$50', '\$100', '\$150', 'All'];

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _applyQuickAmount(String label) {
    final amount = label == 'All' ? ShopperEarningsMockData.availableBalance.toStringAsFixed(2) : label.replaceAll('\$', '');
    setState(() => _amountController.text = amount);
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
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
                          Stack(
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
                                    colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                                  ),
                                ),
                              ),
                              Text(AppStrings.shopperWithdrawEarnings, style: AppTextStyles.titleSmall.copyWith(color: Colors.white)),
                            ],
                          ),
                          SizedBox(height: responsive.spacing(24)),
                          Container(
                            width: double.infinity,
                            padding: responsive.padding(all: 12),
                            decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(responsive.radius(8))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(AppStrings.shopperAvailableBalance, style: AppTextStyles.fieldLabel.copyWith(fontWeight: FontWeight.w500)),
                                Text(
                                  '\$${ShopperEarningsMockData.availableBalance.toStringAsFixed(2)}',
                                  style: TextStyle(fontFamily: AppTextStyles.fieldLabel.fontFamily, fontSize: responsive.fontSize(36), fontWeight: FontWeight.w500, color: AppColors.textPrimary, height: 48 / 36),
                                ),
                                SizedBox(height: responsive.spacing(8)),
                                Text(AppStrings.shopperMinWithdrawal, style: AppTextStyles.bodySmall.copyWith(color: AppColors.textPrimary)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: responsive.padding(horizontal: 16, vertical: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppStrings.shopperWithdrawalAmount, style: AppTextStyles.fieldLabel),
                          SizedBox(height: responsive.spacing(8)),
                          TextField(
                            controller: _amountController,
                            keyboardType: TextInputType.number,
                            style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w500),
                            decoration: const InputDecoration(hintText: '0.00'),
                          ),
                          SizedBox(height: responsive.spacing(8)),
                          Row(
                            children: _quickAmounts.map((label) {
                              return Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(right: label == _quickAmounts.last ? 0 : responsive.spacing(7)),
                                  child: InkWell(
                                    onTap: () => _applyQuickAmount(label),
                                    borderRadius: BorderRadius.circular(responsive.radius(8)),
                                    child: Container(
                                      padding: responsive.padding(vertical: 6),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: AppColors.surface,
                                        borderRadius: BorderRadius.circular(responsive.radius(8)),
                                        boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: responsive.spacing(2))],
                                      ),
                                      child: Text(label, style: AppTextStyles.labelSmall.copyWith(color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          SizedBox(height: responsive.spacing(24)),
                          Text(AppStrings.shopperSendTo, style: AppTextStyles.fieldLabel),
                          SizedBox(height: responsive.spacing(8)),
                          _BankAccountTile(isSelected: _selectedAccount == 0, onTap: () => setState(() => _selectedAccount = 0)),
                          SizedBox(height: responsive.spacing(12)),
                          _BankAccountTile(isSelected: _selectedAccount == 1, onTap: () => setState(() => _selectedAccount = 1)),
                          SizedBox(height: responsive.spacing(24)),
                          AppButton(label: AppStrings.shopperWithdraw, large: true, onPressed: () => context.push(AppRoutes.shopperWithdrawalRequested)),
                          SizedBox(height: responsive.spacing(16)),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(padding: responsive.padding(vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(responsive.radius(8)))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(AppAssets.shopperAddBankIcon, width: responsive.iconSize(16), height: responsive.iconSize(16)),
                                  SizedBox(width: responsive.spacing(10)),
                                  Text(AppStrings.shopperAddBankAccount, style: AppTextStyles.buttonLabelLarge.copyWith(color: AppColors.primary)),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: responsive.spacing(20)),
                          Container(
                            width: double.infinity,
                            padding: responsive.padding(all: 12),
                            decoration: BoxDecoration(color: const Color(0xFFFFF8E1), borderRadius: BorderRadius.circular(responsive.radius(8))),
                            child: Text(AppStrings.shopperWithdrawalWarning, style: AppTextStyles.bodySmall.copyWith(color: AppColors.ratingStar)),
                          ),
                        ],
                      ),
                    ),
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

class _BankAccountTile extends StatelessWidget {
  const _BankAccountTile({required this.isSelected, required this.onTap});

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
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE8F5E9) : AppColors.surface,
          borderRadius: BorderRadius.circular(responsive.radius(8)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: responsive.size(40),
                  height: responsive.size(40),
                  decoration: BoxDecoration(color: AppColors.infoBadgeBackground, borderRadius: BorderRadius.circular(responsive.radius(8))),
                  child: Center(child: SvgPicture.asset(AppAssets.shopperBankIcon, width: responsive.iconSize(24), height: responsive.iconSize(24))),
                ),
                SizedBox(width: responsive.spacing(12)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppStrings.shopperBankName, style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold)),
                    Text(AppStrings.shopperBankAccountSuffix, style: AppTextStyles.bodySmall),
                  ],
                ),
              ],
            ),
            Container(
              width: responsive.size(20),
              height: responsive.size(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: isSelected ? AppColors.primary : AppColors.textSecondary, width: 2),
              ),
              child: Center(
                child: Container(
                  width: responsive.size(10),
                  height: responsive.size(10),
                  decoration: BoxDecoration(color: isSelected ? AppColors.primary : AppColors.textSecondary, shape: BoxShape.circle),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
