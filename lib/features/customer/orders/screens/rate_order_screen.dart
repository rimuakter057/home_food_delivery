import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_card.dart';
import '../state/orders_state.dart';

class RateOrderScreen extends StatefulWidget {
  const RateOrderScreen({super.key, required this.orderId});

  final String orderId;

  @override
  State<RateOrderScreen> createState() => _RateOrderScreenState();
}

class _RateOrderScreenState extends State<RateOrderScreen> {
  int _storeRating = 0;
  int _dasherRating = 0;
  final Set<String> _selectedTags = {};
  final TextEditingController _commentController = TextEditingController();

  static const _tags = [
    'Fresh produce',
    'Fast delivery',
    'Accurate order',
    'Great packaging',
    'Friendly dasher',
  ];

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _submit() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => Dialog(
        backgroundColor: AppColors.background,
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(color: Color(0xFFE8F5E9), shape: BoxShape.circle),
                child: const Icon(Icons.check_rounded, color: AppColors.primary, size: 40),
              ),
              const SizedBox(height: 16),
              Text(AppStrings.thanksForReview, style: AppTextStyles.headlineMedium.copyWith(color: AppColors.textPrimary, fontSize: 20)),
              const SizedBox(height: 8),
              Text(AppStrings.thanksForReviewSubtitle, style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary), textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.of(context, rootNavigator: true).pop();
      context.pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final order = context.watch<OrdersState>().orderById(widget.orderId);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(automaticallyImplyLeading: true),
      body: SafeArea(
        child: ListView(
          padding: responsive.padding(horizontal: 16, vertical: 8),
          children: [
            Row(
              children: [
                Container(
                  width: responsive.size(48),
                  height: responsive.size(48),
                  decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(responsive.radius(12))),
                  child: const Center(child: Text('🌿', style: TextStyle(fontSize: 22))),
                ),
                SizedBox(width: responsive.spacing(12)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppStrings.rateExperienceTitle, style: AppTextStyles.headlineMedium.copyWith(color: AppColors.textPrimary, fontSize: 20)),
                      Text('Order #${order.id} · ${order.kitchenName}', style: AppTextStyles.bodySmall),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: responsive.spacing(20)),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('🏪', style: TextStyle(fontSize: 28)),
                      SizedBox(width: responsive.spacing(10)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(order.kitchenName, style: AppTextStyles.titleSmall),
                          Text(AppStrings.storeQualityLabel, style: AppTextStyles.bodySmall),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: responsive.spacing(16)),
                  Text(AppStrings.howWasStore, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w500)),
                  SizedBox(height: responsive.spacing(8)),
                  _StarRow(rating: _storeRating, onChanged: (r) => setState(() => _storeRating = r)),
                ],
              ),
            ),
            SizedBox(height: responsive.spacing(12)),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(radius: 19, backgroundColor: AppColors.primary, child: Icon(Icons.person, color: Colors.white, size: 20)),
                      SizedBox(width: responsive.spacing(10)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Marcus J.', style: AppTextStyles.titleSmall),
                          Text(AppStrings.dasherCareLabel, style: AppTextStyles.bodySmall),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: responsive.spacing(16)),
                  Text(AppStrings.howWasDasher, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w500)),
                  SizedBox(height: responsive.spacing(8)),
                  _StarRow(rating: _dasherRating, onChanged: (r) => setState(() => _dasherRating = r)),
                ],
              ),
            ),
            SizedBox(height: responsive.spacing(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppStrings.leaveComment, style: AppTextStyles.titleSmall),
                Text(AppStrings.optional, style: AppTextStyles.bodySmall),
              ],
            ),
            SizedBox(height: responsive.spacing(8)),
            TextField(
              controller: _commentController,
              maxLines: 3,
              decoration: const InputDecoration(hintText: AppStrings.commentHint),
            ),
            SizedBox(height: responsive.spacing(20)),
            Text(AppStrings.quickTags, style: AppTextStyles.titleSmall),
            SizedBox(height: responsive.spacing(12)),
            Wrap(
              spacing: responsive.spacing(8),
              runSpacing: responsive.spacing(8),
              children: _tags.map((tag) {
                final isSelected = _selectedTags.contains(tag);
                return InkWell(
                  onTap: () => setState(() => isSelected ? _selectedTags.remove(tag) : _selectedTags.add(tag)),
                  borderRadius: BorderRadius.circular(responsive.radius(24)),
                  child: Container(
                    padding: responsive.padding(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary : AppColors.surface,
                      borderRadius: BorderRadius.circular(responsive.radius(24)),
                    ),
                    child: Text(
                      tag,
                      style: AppTextStyles.bodySmall.copyWith(color: isSelected ? Colors.white : AppColors.textSecondary),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: responsive.spacing(24)),
            AppButton(label: AppStrings.submitReview, onPressed: _submit),
            SizedBox(height: responsive.spacing(12)),
            Center(
              child: TextButton(
                onPressed: () => context.pop(),
                child: Text(AppStrings.skipForNow, style: AppTextStyles.bodySmall),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StarRow extends StatelessWidget {
  const _StarRow({required this.rating, required this.onChanged});

  final int rating;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Row(
      children: List.generate(5, (index) {
        final filled = index < rating;
        return Padding(
          padding: EdgeInsets.only(right: responsive.spacing(8)),
          child: InkWell(
            onTap: () => onChanged(index + 1),
            borderRadius: BorderRadius.circular(responsive.radius(18)),
            child: Icon(
              filled ? Icons.star_rounded : Icons.star_outline_rounded,
              color: AppColors.ratingStar,
              size: responsive.iconSize(32),
            ),
          ),
        );
      }),
    );
  }
}
