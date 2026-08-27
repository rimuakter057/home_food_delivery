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
import '../widgets/shopper_wizard_header.dart';

class _DocumentEntry {
  _DocumentEntry(this.emoji, this.label);
  final String emoji;
  final String label;
  bool uploaded = false;
}

/// Shopper Application step 3/4 (Figma nodes 180:7576 / 180:7768): upload
/// cards that switch to an "uploaded" state once tapped, revealing the
/// Submit Application button once all four are done.
class ShopperDocumentsScreen extends StatefulWidget {
  const ShopperDocumentsScreen({super.key});

  @override
  State<ShopperDocumentsScreen> createState() => _ShopperDocumentsScreenState();
}

class _ShopperDocumentsScreenState extends State<ShopperDocumentsScreen> {
  final _documents = [
    _DocumentEntry('🪪', AppStrings.shopperDocDrivingLicense),
    _DocumentEntry('🆔', AppStrings.shopperDocIdCard),
    _DocumentEntry('📋', AppStrings.shopperDocVehicleRegistration),
    _DocumentEntry('📸', AppStrings.shopperDocProfilePhoto),
  ];

  bool get _allUploaded => _documents.every((doc) => doc.uploaded);

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          ShopperWizardHeader(step: 3, totalSteps: 4, stepLabel: AppStrings.shopperStepDocuments, onBack: () => context.pop()),
          Expanded(
            child: SingleChildScrollView(
              padding: responsive.padding(horizontal: 30, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppStrings.shopperUploadDocuments, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w500)),
                  SizedBox(height: responsive.spacing(8)),
                  for (final doc in _documents) ...[
                    _DocumentCard(document: doc, onUpload: () => setState(() => doc.uploaded = true)),
                    SizedBox(height: responsive.spacing(12)),
                  ],
                  Container(
                    width: double.infinity,
                    padding: responsive.padding(all: 12),
                    decoration: BoxDecoration(color: AppColors.linkBadgeBackground, borderRadius: BorderRadius.circular(responsive.radius(8))),
                    child: Text(AppStrings.shopperDocumentsWarning, style: AppTextStyles.bodySmall.copyWith(color: AppColors.link)),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: responsive.padding(horizontal: 30, vertical: 20),
            child: AppButton(
              label: _allUploaded ? AppStrings.shopperSubmitApplication : AppStrings.continueLabel,
              onPressed: () => context.push(AppRoutes.shopperSubmitted),
            ),
          ),
        ],
      ),
    );
  }
}

class _DocumentCard extends StatelessWidget {
  const _DocumentCard({required this.document, required this.onUpload});

  final _DocumentEntry document;
  final VoidCallback onUpload;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Container(
      width: double.infinity,
      padding: responsive.padding(all: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        border: Border.all(color: document.uploaded ? AppColors.primary : AppColors.divider, width: document.uploaded ? 1 : 2),
        borderRadius: BorderRadius.circular(responsive.radius(8)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(document.emoji, style: TextStyle(fontSize: responsive.fontSize(20.4))),
              SizedBox(width: responsive.spacing(12)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(document.label, style: AppTextStyles.titleSmall),
                  Text(
                    document.uploaded ? AppStrings.shopperUploadedSuccessfully : AppStrings.shopperTapToUpload,
                    style: AppTextStyles.bodySmall,
                  ),
                ],
              ),
            ],
          ),
          if (document.uploaded)
            SvgPicture.asset(AppAssets.shopperUploadCheck, width: responsive.iconSize(22), height: responsive.iconSize(22))
          else
            InkWell(
              onTap: onUpload,
              borderRadius: BorderRadius.circular(responsive.radius(8)),
              child: Container(
                padding: responsive.padding(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(responsive.radius(8))),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(AppAssets.shopperUploadIcon, width: responsive.iconSize(12), height: responsive.iconSize(12)),
                    SizedBox(width: responsive.spacing(6)),
                    Text(AppStrings.shopperUpload, style: AppTextStyles.labelSmall.copyWith(color: Colors.white)),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
