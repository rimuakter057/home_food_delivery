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
import '../state/request_mock_data.dart';

/// The "Set Delivery Window" approve-flow step (Figma nodes 521:6981 /
/// 521:7167): date/time inputs that reveal a Preview + warning once filled,
/// then confirm via [AppStrings.hostApproveAndSave].
class DeliveryWindowScreen extends StatefulWidget {
  const DeliveryWindowScreen({super.key, required this.requestId});

  final String requestId;

  @override
  State<DeliveryWindowScreen> createState() => _DeliveryWindowScreenState();
}

class _DeliveryWindowScreenState extends State<DeliveryWindowScreen> {
  final _dateController = TextEditingController();
  final _startController = TextEditingController(text: '08:00 AM');
  final _endController = TextEditingController(text: '10:00 AM');

  @override
  void dispose() {
    _dateController.dispose();
    _startController.dispose();
    _endController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final request = RequestMockData.byId(widget.requestId);
    final hasDate = _dateController.text.trim().isNotEmpty;

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
                  Text(AppStrings.hostSetDeliveryWindow, style: AppTextStyles.titleLarge),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: responsive.padding(horizontal: 6, vertical: 4),
                      decoration: BoxDecoration(color: AppColors.tealSurface, borderRadius: BorderRadius.circular(responsive.radius(4))),
                      child: Text('Step 1/2', style: AppTextStyles.labelSmall.copyWith(color: AppColors.tealText, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: responsive.padding(horizontal: 16, vertical: 8),
                child: Container(
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: responsive.size(48),
                            height: responsive.size(48),
                            decoration: BoxDecoration(color: const Color(0xFFFFF3E0), borderRadius: BorderRadius.circular(responsive.radius(8))),
                            child: Center(child: SvgPicture.asset(AppAssets.hostClockIcon, width: responsive.iconSize(24), height: responsive.iconSize(24))),
                          ),
                          SizedBox(width: responsive.spacing(12)),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(AppStrings.hostConfirmDeliveryWindow, style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold, fontSize: 16)),
                                SizedBox(height: responsive.spacing(4)),
                                Text(AppStrings.hostConfirmDeliveryWindowSubtitle, style: AppTextStyles.bodySmall),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: responsive.spacing(16)),
                      Text(AppStrings.hostDeliveryDate, style: AppTextStyles.fieldLabel),
                      SizedBox(height: responsive.spacing(8)),
                      TextField(
                        controller: _dateController,
                        onChanged: (_) => setState(() {}),
                        decoration: const InputDecoration(hintText: 'mm/dd/yyyy', suffixIcon: Icon(Icons.calendar_today_outlined, size: 16)),
                      ),
                      SizedBox(height: responsive.spacing(12)),
                      Text(AppStrings.hostStartTime, style: AppTextStyles.fieldLabel),
                      SizedBox(height: responsive.spacing(8)),
                      TextField(controller: _startController, onChanged: (_) => setState(() {})),
                      SizedBox(height: responsive.spacing(12)),
                      Text(AppStrings.hostEndTime, style: AppTextStyles.fieldLabel),
                      SizedBox(height: responsive.spacing(8)),
                      TextField(controller: _endController, onChanged: (_) => setState(() {})),
                      if (hasDate) ...[
                        SizedBox(height: responsive.spacing(24)),
                        Container(
                          width: double.infinity,
                          padding: responsive.padding(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(color: const Color(0xFFD4EBE6), border: Border.all(color: AppColors.border, width: 0.5), borderRadius: BorderRadius.circular(responsive.radius(8))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(AppStrings.hostPreview, style: AppTextStyles.labelSmall.copyWith(color: AppColors.tealText, fontWeight: FontWeight.bold)),
                              SizedBox(height: responsive.spacing(6)),
                              Text(request.propertyAddress, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w500)),
                              Text(
                                '${_startController.text} - ${_endController.text}',
                                style: AppTextStyles.bodySmall.copyWith(color: AppColors.tealText, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: responsive.spacing(12)),
                        Container(
                          width: double.infinity,
                          padding: responsive.padding(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(color: const Color(0xFFFFF3E0), border: Border.all(color: AppColors.border, width: 0.5), borderRadius: BorderRadius.circular(responsive.radius(8))),
                          child: Text(AppStrings.hostGuestStayWarning, style: AppTextStyles.caption.copyWith(color: AppColors.ratingStar)),
                        ),
                      ],
                      SizedBox(height: responsive.spacing(24)),
                      AppButton(
                        label: AppStrings.hostApproveAndSave,
                        large: true,
                        onPressed: () => context.push(AppRoutes.hostDeliveryApprovedPath(widget.requestId)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
