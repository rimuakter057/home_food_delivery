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

class _SavedAddress {
  const _SavedAddress(this.line1, this.line2);
  final String line1;
  final String line2;
}

class SelectAddressScreen extends StatefulWidget {
  const SelectAddressScreen({super.key});

  @override
  State<SelectAddressScreen> createState() => _SelectAddressScreenState();
}

class _SelectAddressScreenState extends State<SelectAddressScreen> {
  static const _addresses = [
    _SavedAddress('789 Park Avenue', 'New York, NY 10021 . 0.8 mi'),
    _SavedAddress('456 Broadway, Floor 3', 'New York, NY 10013 . 0.8 mi'),
    _SavedAddress('456 Broadway, Floor 3', 'New York, NY 10013 . 0.8 mi'),
  ];

  int _selectedAddress = 0;
  int _selectedTag = 0;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          SizedBox(
            height: responsive.size(351),
            width: double.infinity,
            child: Stack(
              children: [
                // No maps SDK is wired up — a static Figma-exported map
                // image stands in for the live map tile.
                Positioned.fill(
                  child: Image.asset(AppAssets.mapStatic, fit: BoxFit.cover),
                ),
                SafeArea(
                  child: Padding(
                    padding: responsive.padding(horizontal: 30, vertical: 12),
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
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: responsive.size(40),
                        height: responsive.size(40),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(color: const Color(0x802E7D32), blurRadius: responsive.spacing(6), offset: Offset(0, responsive.spacing(4))),
                          ],
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            AppAssets.locationPinSmall,
                            width: responsive.iconSize(20),
                            height: responsive.iconSize(20),
                            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                          ),
                        ),
                      ),
                      SizedBox(height: responsive.spacing(2)),
                      Container(
                        width: responsive.size(8),
                        height: responsive.size(8),
                        decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: SafeArea(
                    child: Padding(
                      padding: responsive.padding(vertical: 12),
                      child: Container(
                        padding: responsive.padding(horizontal: 11, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(responsive.radius(24)),
                          boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: responsive.spacing(4))],
                        ),
                        child: Text(
                          AppStrings.moveMapToSetLocation,
                          style: AppTextStyles.labelSmall.copyWith(color: AppColors.primary, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: responsive.padding(horizontal: 30, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppStrings.setYourAddress, style: AppTextStyles.fieldLabel),
                  SizedBox(height: responsive.spacing(12)),
                  Container(
                    padding: responsive.padding(horizontal: 16, vertical: 15),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      border: Border.all(color: AppColors.border, width: 0.5),
                      borderRadius: BorderRadius.circular(responsive.radius(8)),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(AppAssets.search, width: 16, height: 16),
                        SizedBox(width: responsive.spacing(6)),
                        Text(AppStrings.searchForAddress, style: AppTextStyles.placeholder),
                      ],
                    ),
                  ),
                  SizedBox(height: responsive.spacing(24)),
                  ...List.generate(_addresses.length, (index) {
                    final address = _addresses[index];
                    final isSelected = index == _selectedAddress;
                    return Padding(
                      padding: EdgeInsets.only(bottom: responsive.spacing(12)),
                      child: InkWell(
                        onTap: () => setState(() => _selectedAddress = index),
                        borderRadius: BorderRadius.circular(responsive.radius(8)),
                        child: Container(
                          padding: responsive.padding(all: 12),
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xFFE8F5E9) : AppColors.surface,
                            borderRadius: BorderRadius.circular(responsive.radius(8)),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                AppAssets.locationPinSmall,
                                width: 16,
                                height: 19,
                                colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
                              ),
                              SizedBox(width: responsive.spacing(6)),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(address.line1, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w500)),
                                    SizedBox(height: responsive.spacing(4)),
                                    Text(address.line2, style: AppTextStyles.bodySmall),
                                  ],
                                ),
                              ),
                              if (isSelected)
                                const Icon(Icons.check_circle_rounded, color: AppColors.primary, size: 16),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                  SizedBox(height: responsive.spacing(12)),
                  Text(AppStrings.saveAs, style: AppTextStyles.titleSmall),
                  SizedBox(height: responsive.spacing(8)),
                  Row(
                    children: [
                      _TagChip(
                        icon: Icons.home_rounded,
                        label: AppStrings.addressTagHome,
                        isSelected: _selectedTag == 0,
                        onTap: () => setState(() => _selectedTag = 0),
                      ),
                      SizedBox(width: responsive.spacing(12)),
                      _TagChip(
                        icon: Icons.work_rounded,
                        label: AppStrings.addressTagWork,
                        isSelected: _selectedTag == 1,
                        onTap: () => setState(() => _selectedTag = 1),
                      ),
                      SizedBox(width: responsive.spacing(12)),
                      _TagChip(
                        icon: Icons.more_horiz_rounded,
                        label: AppStrings.addressTagOther,
                        isSelected: _selectedTag == 2,
                        onTap: () => setState(() => _selectedTag = 2),
                      ),
                    ],
                  ),
                  SizedBox(height: responsive.spacing(24)),
                  AppButton(
                    label: AppStrings.confirmAddress,
                    variant: AppButtonVariant.outline,
                    large: true,
                    onPressed: () => context.go(AppRoutes.home),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  const _TagChip({required this.icon, required this.label, required this.isSelected, required this.onTap});

  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(responsive.radius(24)),
      child: Container(
        padding: responsive.padding(horizontal: 16, vertical: 9),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(responsive.radius(24)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 13, color: isSelected ? Colors.white : AppColors.textSecondary),
            SizedBox(width: responsive.spacing(6)),
            Text(
              label,
              style: AppTextStyles.labelSmall.copyWith(
                color: isSelected ? Colors.white : AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
