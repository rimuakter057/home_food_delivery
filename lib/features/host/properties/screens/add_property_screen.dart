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
import '../../../../core/widgets/dashed_border_container.dart';

/// The Host "Add Property" form (Figma node 507:4679).
class AddPropertyScreen extends StatefulWidget {
  const AddPropertyScreen({super.key});

  @override
  State<AddPropertyScreen> createState() => _AddPropertyScreenState();
}

class _AddPropertyScreenState extends State<AddPropertyScreen> {
  final _nameController = TextEditingController();
  final _typeController = TextEditingController();
  final _streetController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _typeController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
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
                  Text(AppStrings.hostAddPropertyTitle, style: AppTextStyles.titleLarge),
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
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(responsive.radius(8)),
                        boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: responsive.spacing(4), offset: Offset(0, responsive.spacing(2)))],
                      ),
                      child: DashedBorderContainer(
                        radius: responsive.radius(8),
                        child: Container(
                          width: double.infinity,
                          padding: responsive.padding(vertical: 43),
                          child: Column(
                            children: [
                              SvgPicture.asset(AppAssets.hostCameraUpload, width: responsive.iconSize(32), height: responsive.iconSize(32)),
                              SizedBox(height: responsive.spacing(12)),
                              Text(AppStrings.hostUploadPropertyImage, style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: responsive.spacing(16)),
                    AppTextField(label: AppStrings.hostPropertyName, hint: AppStrings.hostPropertyNameHint, controller: _nameController),
                    SizedBox(height: responsive.spacing(12)),
                    AppTextField(label: AppStrings.hostPropertyType, hint: AppStrings.hostPropertyTypeHint, controller: _typeController),
                    SizedBox(height: responsive.spacing(16)),
                    Text(AppStrings.hostAddressDetails, style: AppTextStyles.fieldLabel),
                    SizedBox(height: responsive.spacing(8)),
                    AppTextField(hint: AppStrings.hostStreetAddress, controller: _streetController),
                    SizedBox(height: responsive.spacing(12)),
                    Row(
                      children: [
                        Expanded(child: AppTextField(hint: AppStrings.hostCity, controller: _cityController)),
                        SizedBox(width: responsive.spacing(10)),
                        Expanded(child: AppTextField(hint: AppStrings.hostState, controller: _stateController)),
                      ],
                    ),
                    SizedBox(height: responsive.spacing(12)),
                    Row(
                      children: [
                        Expanded(child: AppTextField(hint: AppStrings.hostZipCode, controller: _zipController)),
                        SizedBox(width: responsive.spacing(10)),
                        Expanded(
                          child: Container(
                            height: responsive.size(48),
                            padding: responsive.padding(horizontal: 16),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              border: Border.all(color: AppColors.border, width: 0.5),
                              borderRadius: BorderRadius.circular(responsive.radius(8)),
                            ),
                            child: Text(AppStrings.hostCountry, style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: responsive.spacing(24)),
                    AppButton(
                      label: AppStrings.hostSaveProperty,
                      large: true,
                      onPressed: () => context.push(AppRoutes.hostPropertyCreated),
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
