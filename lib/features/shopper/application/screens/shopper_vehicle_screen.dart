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
import '../../../../core/widgets/app_text_field.dart';
import '../widgets/shopper_wizard_header.dart';

enum _VehicleType { bicycle, scooter, car }

/// Shopper Application step 2/4 (Figma node 180:7136): vehicle type picker
/// plus license/plate number fields.
class ShopperVehicleScreen extends StatefulWidget {
  const ShopperVehicleScreen({super.key});

  @override
  State<ShopperVehicleScreen> createState() => _ShopperVehicleScreenState();
}

class _ShopperVehicleScreenState extends State<ShopperVehicleScreen> {
  final _licenseController = TextEditingController();
  final _plateController = TextEditingController();
  _VehicleType _selected = _VehicleType.bicycle;

  @override
  void dispose() {
    _licenseController.dispose();
    _plateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          ShopperWizardHeader(step: 2, totalSteps: 4, stepLabel: AppStrings.shopperStepVehicle, onBack: () => context.pop()),
          Expanded(
            child: SingleChildScrollView(
              padding: responsive.padding(horizontal: 30, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppStrings.shopperVehicleType, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w500)),
                  SizedBox(height: responsive.spacing(8)),
                  Row(
                    children: [
                      Expanded(
                        child: _VehicleOption(
                          emoji: '🚲',
                          label: AppStrings.shopperBicycle,
                          isSelected: _selected == _VehicleType.bicycle,
                          onTap: () => setState(() => _selected = _VehicleType.bicycle),
                        ),
                      ),
                      SizedBox(width: responsive.spacing(14)),
                      Expanded(
                        child: _VehicleOption(
                          emoji: '🛵',
                          label: AppStrings.shopperScooter,
                          isSelected: _selected == _VehicleType.scooter,
                          onTap: () => setState(() => _selected = _VehicleType.scooter),
                        ),
                      ),
                      SizedBox(width: responsive.spacing(14)),
                      Expanded(
                        child: _VehicleOption(
                          emoji: '🚗',
                          label: AppStrings.shopperCar,
                          isSelected: _selected == _VehicleType.car,
                          onTap: () => setState(() => _selected = _VehicleType.car),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: responsive.spacing(24)),
                  AppTextField(
                    label: AppStrings.shopperLicenseNumber,
                    hint: AppStrings.shopperLicenseNumberHint,
                    controller: _licenseController,
                    prefixWidget: Padding(
                      padding: responsive.padding(all: 12),
                      child: SvgPicture.asset(AppAssets.shopperLicenseIcon, width: responsive.iconSize(18), height: responsive.iconSize(18)),
                    ),
                  ),
                  SizedBox(height: responsive.spacing(12)),
                  AppTextField(
                    label: AppStrings.shopperPlateNumber,
                    hint: AppStrings.shopperPlateNumberHint,
                    controller: _plateController,
                    prefixWidget: Padding(
                      padding: responsive.padding(all: 12),
                      child: SvgPicture.asset(AppAssets.shopperPlateIcon, width: responsive.iconSize(18), height: responsive.iconSize(18)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: responsive.padding(horizontal: 30, vertical: 20),
            child: AppButton(label: AppStrings.continueLabel, onPressed: () => context.push(AppRoutes.shopperDocuments)),
          ),
        ],
      ),
    );
  }
}

class _VehicleOption extends StatelessWidget {
  const _VehicleOption({required this.emoji, required this.label, required this.isSelected, required this.onTap});

  final String emoji;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(responsive.radius(8)),
      child: Container(
        height: responsive.size(90),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE8F5E9) : const Color(0xFFFAFAFA),
          border: isSelected ? Border.all(color: AppColors.primary, width: 2) : null,
          borderRadius: BorderRadius.circular(responsive.radius(8)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: TextStyle(fontSize: responsive.fontSize(25.5))),
            SizedBox(height: responsive.spacing(6)),
            Text(
              label,
              style: AppTextStyles.labelSmall.copyWith(color: isSelected ? AppColors.primary : AppColors.textSecondary, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
