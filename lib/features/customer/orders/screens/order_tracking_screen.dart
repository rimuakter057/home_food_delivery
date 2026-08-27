import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/widgets/app_button.dart';
import '../../navigation/state/navigation_state.dart';
import '../state/order_models.dart';
import '../state/orders_state.dart';

class OrderTrackingScreen extends StatefulWidget {
  const OrderTrackingScreen({super.key, required this.orderId});

  final String orderId;

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  bool _expanded = false;

  static const _steps = [
    (status: OrderStatus.placed, label: AppStrings.trackingStepOrderConfirmed, icon: AppAssets.trackingStepConfirmed),
    (status: OrderStatus.confirmed, label: AppStrings.trackingStepDasherAssigned, icon: AppAssets.trackingStepTruck),
    (status: OrderStatus.preparing, label: AppStrings.trackingStepPickingUpItems, icon: AppAssets.trackingStepBox),
    (status: OrderStatus.onTheWay, label: AppStrings.statusOnTheWay, icon: AppAssets.trackingStepTruck),
    (status: OrderStatus.delivered, label: AppStrings.statusDelivered, icon: AppAssets.trackingStepDelivered),
  ];

  String _formatTime(DateTime time) {
    final hour12 = time.hour % 12 == 0 ? 12 : time.hour % 12;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.hour >= 12 ? 'PM' : 'AM';
    return '$hour12:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final order = context.watch<OrdersState>().orderById(widget.orderId);
    final currentIndex = OrderStatus.values.indexOf(order.status);
    final currentLabel = _steps[currentIndex.clamp(0, _steps.length - 1)].label;
    final isDelivered = order.status == OrderStatus.delivered;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: responsive.size(300),
              width: double.infinity,
              child: Stack(
                children: [
                  // No maps SDK is wired up — a static Figma-exported map
                  // image stands in for the live map tile.
                  Positioned.fill(
                    child: Image.asset(AppAssets.mapStatic, fit: BoxFit.cover),
                  ),
                  const Center(child: Text('🚴', style: TextStyle(fontSize: 40))),
                  Padding(
                    padding: responsive.padding(horizontal: 16, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: responsive.padding(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.9),
                            borderRadius: BorderRadius.circular(responsive.radius(8)),
                          ),
                          child: Text('${AppStrings.orderIdLabel} #${order.id}', style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary)),
                        ),
                        if (!isDelivered)
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: responsive.size(8),
                                height: responsive.size(8),
                                decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                              ),
                              SizedBox(width: responsive.spacing(4)),
                              Text(
                                '${order.estimatedDeliveryMinutes} ${AppStrings.minutes} away',
                                style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        Container(
                          padding: responsive.padding(horizontal: 12, vertical: 7),
                          decoration: BoxDecoration(color: AppColors.error.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(responsive.radius(8))),
                          child: Text(AppStrings.cancel, style: AppTextStyles.labelSmall.copyWith(color: AppColors.error)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: responsive.padding(horizontal: 16, vertical: 16),
                children: [
                  Row(
                    children: [
                      ClipOval(
                        child: Image.asset(AppAssets.dasherAvatar, width: responsive.size(42), height: responsive.size(42), fit: BoxFit.cover),
                      ),
                      SizedBox(width: responsive.spacing(12)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Marcus J.', style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold)),
                            Row(
                              children: [
                                const Text('★★★★★', style: TextStyle(fontSize: 12, color: Color(0xFFEAB308))),
                                SizedBox(width: responsive.spacing(4)),
                                Text('1,240 deliveries', style: AppTextStyles.bodySmall),
                              ],
                            ),
                          ],
                        ),
                      ),
                      _CircleIconButton(icon: AppAssets.trackingChat, background: AppColors.infoBadgeBackground),
                      SizedBox(width: responsive.spacing(12)),
                      _CircleIconButton(icon: AppAssets.trackingPhone, background: AppColors.stepDoneBackground),
                    ],
                  ),
                  SizedBox(height: responsive.spacing(20)),
                  InkWell(
                    onTap: () => setState(() => _expanded = !_expanded),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(currentLabel, style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold)),
                        SvgPicture.asset(
                          AppAssets.trackingChevron,
                          width: responsive.iconSize(16),
                          height: responsive.iconSize(16),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: responsive.spacing(12)),
                  if (_expanded)
                    _TimelineList(steps: _steps, currentIndex: currentIndex, timestamp: _formatTime(order.placedAt))
                  else
                    Row(
                      children: List.generate(_steps.length, (index) {
                        final isDone = index <= currentIndex;
                        return Expanded(
                          child: Container(
                            height: responsive.size(6),
                            margin: EdgeInsets.only(right: index == _steps.length - 1 ? 0 : responsive.spacing(6)),
                            decoration: BoxDecoration(
                              color: isDone ? AppColors.primary : AppColors.divider,
                              borderRadius: BorderRadius.circular(responsive.radius(3)),
                            ),
                          ),
                        );
                      }),
                    ),
                  if (isDelivered) ...[
                    SizedBox(height: responsive.spacing(20)),
                    AppButton(
                      label: '⭐ ${AppStrings.rateExperienceTitle}',
                      onPressed: () => context.push(AppRoutes.rateOrderPath(widget.orderId)),
                    ),
                  ],
                  SizedBox(height: responsive.spacing(28)),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        context.read<NavigationState>().setIndex(0);
                        context.go(AppRoutes.home);
                      },
                      child: Text(AppStrings.backToHome, style: AppTextStyles.labelSmall),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

typedef _TrackingStep = ({OrderStatus status, String label, String icon});

class _TimelineList extends StatelessWidget {
  const _TimelineList({required this.steps, required this.currentIndex, required this.timestamp});

  final List<_TrackingStep> steps;
  final int currentIndex;
  final String timestamp;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Column(
      children: List.generate(steps.length, (index) {
        final step = steps[index];
        final isDone = index <= currentIndex;
        final isCurrent = index == currentIndex;
        final isLast = index == steps.length - 1;
        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: responsive.size(28),
                    height: responsive.size(28),
                    decoration: BoxDecoration(
                      color: isDone ? AppColors.primary : AppColors.divider,
                      shape: BoxShape.circle,
                      border: isCurrent ? Border.all(color: AppColors.primary, width: 2) : null,
                    ),
                    padding: responsive.padding(all: 7),
                    child: SvgPicture.asset(step.icon, colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn)),
                  ),
                  if (!isLast)
                    Expanded(
                      child: Container(
                        width: 2,
                        margin: responsive.padding(vertical: 4),
                        color: isDone ? AppColors.primary : AppColors.divider,
                      ),
                    ),
                ],
              ),
              SizedBox(width: responsive.spacing(12)),
              Padding(
                padding: EdgeInsets.only(bottom: isLast ? 0 : responsive.spacing(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(step.label, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w500)),
                    Text(timestamp, style: AppTextStyles.bodySmall),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({required this.icon, required this.background});

  final String icon;
  final Color background;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Container(
      width: responsive.size(38),
      height: responsive.size(38),
      decoration: BoxDecoration(color: background, shape: BoxShape.circle),
      child: Center(
        child: SvgPicture.asset(icon, width: responsive.iconSize(15), height: responsive.iconSize(15)),
      ),
    );
  }
}
