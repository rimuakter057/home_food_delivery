import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/custom_app_bar.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  static const _faqs = [
    'How do I track my order?',
    'Can I cancel my order?',
    'What if items are missing or wrong?',
    'How do refunds work?',
    'How do I change my delivery address?',
    'Is there a minimum order amount?',
    'How do I apply a promo code?',
  ];

  @override
  void dispose() {
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _send() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text(AppStrings.messageSentConfirm)),
    );
    _subjectController.clear();
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(title: AppStrings.helpSupport),
      body: SafeArea(
        child: ListView(
          padding: responsive.padding(all: 16),
          children: [
            Text(AppStrings.emailUsOnline, style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w600)),
            SizedBox(height: responsive.spacing(12)),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: responsive.size(40),
                        height: responsive.size(40),
                        decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(responsive.radius(8))),
                        child: const Icon(Icons.mail_outline_rounded, color: AppColors.primary, size: 18),
                      ),
                      SizedBox(width: responsive.spacing(6)),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(text: 'Email Us ', style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w600)),
                            TextSpan(text: 'Online', style: AppTextStyles.bodySmall.copyWith(color: AppColors.primary)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: responsive.spacing(16)),
                  AppTextField(label: AppStrings.subject, hint: '', controller: _subjectController),
                  SizedBox(height: responsive.spacing(12)),
                  TextField(
                    controller: _messageController,
                    maxLines: 4,
                    decoration: const InputDecoration(hintText: AppStrings.describeIssue),
                  ),
                  SizedBox(height: responsive.spacing(16)),
                  AppButton(label: AppStrings.sendMessage, onPressed: _send),
                ],
              ),
            ),
            SizedBox(height: responsive.spacing(24)),
            Text(AppStrings.faqTitle, style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w600)),
            SizedBox(height: responsive.spacing(12)),
            AppCard(
              padding: EdgeInsets.zero,
              child: Theme(
                data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                child: Column(
                  children: [
                    for (var i = 0; i < _faqs.length; i++) ...[
                      if (i > 0) const Divider(height: 1),
                      ExpansionTile(
                        title: Text(_faqs[i], style: AppTextStyles.bodySmall.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w500)),
                        childrenPadding: responsive.padding(horizontal: 16, vertical: 12).copyWith(top: 0),
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Open the order from My Orders to see live status and details.',
                              style: AppTextStyles.bodySmall,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
            SizedBox(height: responsive.spacing(24)),
            AppCard(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppStrings.appName, style: AppTextStyles.titleSmall),
                        Text(AppStrings.appVersion, style: AppTextStyles.bodySmall),
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_right_rounded, size: responsive.iconSize(18), color: AppColors.textSecondary),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
