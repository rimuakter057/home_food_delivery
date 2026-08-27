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
import '../../../../core/widgets/app_card.dart';
import '../../cart/state/cart_state.dart';
import '../../orders/state/orders_state.dart';
import '../../profile/state/profile_mock_data.dart';
import '../widgets/address_tile.dart';
import '../widgets/payment_method_tile.dart';

enum _CheckoutStep { address, delivery, payment, review }

enum _DeliveryOption { asap, schedule }

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  _CheckoutStep _step = _CheckoutStep.address;
  late String _selectedAddressId;
  late String _selectedPaymentId;
  _DeliveryOption _deliveryOption = _DeliveryOption.asap;
  int _tipIndex = 2; // 15%
  static const _tipOptions = ['None', '10%', '15%', '20%', '25%'];

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedAddressId = ProfileMockData.addresses.firstWhere((a) => a.isDefault).id;
    _selectedPaymentId = ProfileMockData.paymentMethods.firstWhere((p) => p.isDefault).id;
  }

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  double get _tipAmount {
    final cart = context.read<CartState>();
    const percents = [0.0, 0.10, 0.15, 0.20, 0.25];
    return cart.subtotal * percents[_tipIndex];
  }

  double get _serviceFee => 0.99;

  double get _orderTotal {
    final cart = context.read<CartState>();
    return cart.subtotal + _serviceFee + _tipAmount;
  }

  void _goBack() {
    if (_step == _CheckoutStep.address) {
      context.pop();
    } else {
      setState(() => _step = _CheckoutStep.values[_step.index - 1]);
    }
  }

  void _continue() {
    if (_step == _CheckoutStep.review) {
      _placeOrder();
    } else {
      setState(() => _step = _CheckoutStep.values[_step.index + 1]);
    }
  }

  void _placeOrder() {
    final cart = context.read<CartState>();
    final order = context.read<OrdersState>().placeOrder(items: cart.items, total: _orderTotal);
    cart.clear();
    context.pushReplacement(AppRoutes.orderSuccessPath(order.id));
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final cart = context.watch<CartState>();

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
                      onTap: _goBack,
                      borderRadius: BorderRadius.circular(responsive.radius(12)),
                      child: SvgPicture.asset(
                        AppAssets.chevronBack,
                        width: responsive.iconSize(24),
                        height: responsive.iconSize(24),
                        colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
                      ),
                    ),
                  ),
                  Text(AppStrings.checkoutTitle, style: AppTextStyles.titleLarge),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text('Step ${_step.index + 1}/4', style: AppTextStyles.bodySmall),
                  ),
                ],
              ),
            ),
            Padding(
              padding: responsive.padding(horizontal: 16, vertical: 8),
              child: _StepIndicator(currentStep: _step.index),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: responsive.padding(horizontal: 16, vertical: 8),
                child: switch (_step) {
                  _CheckoutStep.address => _AddressStep(
                      selectedAddressId: _selectedAddressId,
                      onSelect: (id) => setState(() => _selectedAddressId = id),
                    ),
                  _CheckoutStep.delivery => _DeliveryStep(
                      option: _deliveryOption,
                      onSelect: (option) => setState(() => _deliveryOption = option),
                      dateController: _dateController,
                      timeController: _timeController,
                    ),
                  _CheckoutStep.payment => _PaymentStep(
                      selectedPaymentId: _selectedPaymentId,
                      onSelect: (id) => setState(() => _selectedPaymentId = id),
                      tipIndex: _tipIndex,
                      tipOptions: _tipOptions,
                      onTipSelect: (index) => setState(() => _tipIndex = index),
                    ),
                  _CheckoutStep.review => _ReviewStep(
                      address: ProfileMockData.addresses.firstWhere((a) => a.id == _selectedAddressId),
                      payment: ProfileMockData.paymentMethods.firstWhere((p) => p.id == _selectedPaymentId),
                      isAsap: _deliveryOption == _DeliveryOption.asap,
                      subtotal: cart.subtotal,
                      serviceFee: _serviceFee,
                      tip: _tipAmount,
                      total: _orderTotal,
                    ),
                },
              ),
            ),
            Padding(
              padding: responsive.padding(horizontal: 16, vertical: 16),
              child: AppButton(
                label: _step == _CheckoutStep.review
                    ? '${AppStrings.placeOrder} · ${AppStrings.currencySymbol}${_orderTotal.toStringAsFixed(2)}'
                    : AppStrings.continueLabel,
                large: true,
                onPressed: _continue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StepIndicator extends StatelessWidget {
  const _StepIndicator({required this.currentStep});

  final int currentStep;

  static const _labels = [
    AppStrings.checkoutStepAddress,
    AppStrings.checkoutStepDelivery,
    AppStrings.checkoutStepPayment,
    AppStrings.checkoutStepReview,
  ];

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Row(
      children: List.generate(_labels.length * 2 - 1, (i) {
        if (i.isOdd) {
          final leftDone = (i - 1) ~/ 2 < currentStep;
          return Expanded(
            child: Container(height: 2, color: leftDone ? AppColors.primary : AppColors.divider),
          );
        }
        final index = i ~/ 2;
        final isDone = index < currentStep;
        final isCurrent = index == currentStep;
        return Column(
          children: [
            Container(
              width: responsive.size(24),
              height: responsive.size(24),
              decoration: BoxDecoration(
                color: isDone || isCurrent ? AppColors.primary : AppColors.divider,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: isDone
                    ? const Icon(Icons.check, color: Colors.white, size: 14)
                    : Text(
                        '${index + 1}',
                        style: TextStyle(color: isCurrent ? Colors.white : AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
              ),
            ),
            SizedBox(height: responsive.spacing(4)),
            Text(_labels[index], style: AppTextStyles.bodySmall.copyWith(fontSize: 11)),
          ],
        );
      }),
    );
  }
}

enum _AddressTab { myAddress, propertyCode }

class _AddressStep extends StatefulWidget {
  const _AddressStep({required this.selectedAddressId, required this.onSelect});

  final String selectedAddressId;
  final ValueChanged<String> onSelect;

  @override
  State<_AddressStep> createState() => _AddressStepState();
}

class _AddressStepState extends State<_AddressStep> {
  _AddressTab _tab = _AddressTab.myAddress;
  final _codeController = TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.deliveryAddressTitle, style: AppTextStyles.fieldLabel),
        SizedBox(height: responsive.spacing(24)),
        _AddressTabSwitcher(active: _tab, onChanged: (tab) => setState(() => _tab = tab)),
        SizedBox(height: responsive.spacing(24)),
        if (_tab == _AddressTab.myAddress)
          ...ProfileMockData.addresses.map(
            (address) => AddressTile(
              address: address,
              isSelected: address.id == widget.selectedAddressId,
              onTap: () => widget.onSelect(address.id),
            ),
          )
        else
          _PropertyCodeTab(controller: _codeController),
      ],
    );
  }
}

class _AddressTabSwitcher extends StatelessWidget {
  const _AddressTabSwitcher({required this.active, required this.onChanged});

  final _AddressTab active;
  final ValueChanged<_AddressTab> onChanged;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Container(
      padding: responsive.padding(all: 4),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(responsive.radius(8)),
        boxShadow: [
          BoxShadow(color: AppColors.cardShadow, blurRadius: responsive.spacing(4), offset: Offset(0, responsive.spacing(2))),
        ],
      ),
      child: Row(
        children: [
          Expanded(child: _tabButton(context, AppStrings.addressTabMyAddress, _AddressTab.myAddress)),
          Expanded(child: _tabButton(context, AppStrings.addressTabPropertyCode, _AddressTab.propertyCode)),
        ],
      ),
    );
  }

  Widget _tabButton(BuildContext context, String label, _AddressTab tab) {
    final responsive = context.responsive;
    final isActive = tab == active;
    return InkWell(
      onTap: () => onChanged(tab),
      borderRadius: BorderRadius.circular(responsive.radius(4)),
      child: Container(
        height: responsive.size(30),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary.withValues(alpha: 0.15) : Colors.transparent,
          border: isActive ? Border.all(color: AppColors.primary) : null,
          borderRadius: BorderRadius.circular(responsive.radius(4)),
        ),
        child: Text(
          label,
          style: isActive
              ? AppTextStyles.fieldLabel.copyWith(color: AppColors.primary)
              : AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
        ),
      ),
    );
  }
}

class _PropertyCodeTab extends StatefulWidget {
  const _PropertyCodeTab({required this.controller});

  final TextEditingController controller;

  @override
  State<_PropertyCodeTab> createState() => _PropertyCodeTabState();
}

class _PropertyCodeTabState extends State<_PropertyCodeTab> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onChanged);
    super.dispose();
  }

  void _onChanged() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final hasCode = widget.controller.text.trim().isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: responsive.padding(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.tealSurface,
            border: Border.all(color: AppColors.border, width: 0.5),
            borderRadius: BorderRadius.circular(responsive.radius(8)),
          ),
          child: Text(
            AppStrings.propertyCodeInfoBanner,
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.tealText, fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(height: responsive.spacing(12)),
        Text(AppStrings.propertyCodeLabel, style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary)),
        SizedBox(height: responsive.spacing(12)),
        Container(
          padding: responsive.padding(horizontal: 17, vertical: 13),
          decoration: BoxDecoration(
            color: AppColors.tealSurface,
            border: Border.all(color: AppColors.tealText),
            borderRadius: BorderRadius.circular(responsive.radius(8)),
          ),
          child: Row(
            children: [
              SvgPicture.asset(AppAssets.propertyCodeKey, width: responsive.iconSize(20), height: responsive.iconSize(20)),
              SizedBox(width: responsive.spacing(12)),
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  textCapitalization: TextCapitalization.characters,
                  style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold, fontSize: 16, height: 28 / 16),
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    hintText: AppStrings.propertyCodeHint,
                    hintStyle: AppTextStyles.placeholder,
                  ),
                ),
              ),
              if (hasCode)
                SvgPicture.asset(AppAssets.propertyCodeCheck, width: responsive.iconSize(20), height: responsive.iconSize(20)),
            ],
          ),
        ),
        if (hasCode) ...[
          SizedBox(height: responsive.spacing(12)),
          _PropertyFoundCard(),
        ],
      ],
    );
  }
}

class _PropertyFoundCard extends StatelessWidget {
  const _PropertyFoundCard();

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Container(
      width: double.infinity,
      padding: responsive.padding(all: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(responsive.radius(8)),
        boxShadow: [
          BoxShadow(color: AppColors.cardShadow, blurRadius: responsive.spacing(4), offset: Offset(0, responsive.spacing(2))),
        ],
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
                decoration: BoxDecoration(
                  color: AppColors.tealSurface,
                  borderRadius: BorderRadius.circular(responsive.radius(8)),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    AppAssets.propertyBuildingSmall,
                    width: responsive.iconSize(24),
                    height: responsive.iconSize(24),
                  ),
                ),
              ),
              SizedBox(width: responsive.spacing(12)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            AppStrings.propertyFoundDowntownLoft,
                            style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding: responsive.padding(horizontal: 12, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.infoBadgeBackground,
                            borderRadius: BorderRadius.circular(responsive.radius(8)),
                          ),
                          child: Text(
                            AppStrings.propertyFoundHostApproved,
                            style: AppTextStyles.labelSmall.copyWith(color: AppColors.link, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: responsive.spacing(4)),
                    Text(
                      '${AppStrings.propertyFoundManagedByPrefix}${AppStrings.propertyFoundSunsetRentals}',
                      style: AppTextStyles.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: responsive.spacing(10)),
          Divider(color: Colors.black.withValues(alpha: 0.5), height: 1),
          SizedBox(height: responsive.spacing(10)),
          Text(
            AppStrings.propertyFoundPrivacyNote,
            style: AppTextStyles.caption.copyWith(color: AppColors.textPrimary, fontSize: 10),
          ),
        ],
      ),
    );
  }
}

class _DeliveryStep extends StatelessWidget {
  const _DeliveryStep({
    required this.option,
    required this.onSelect,
    required this.dateController,
    required this.timeController,
  });

  final _DeliveryOption option;
  final ValueChanged<_DeliveryOption> onSelect;
  final TextEditingController dateController;
  final TextEditingController timeController;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.deliveryTimeTitle, style: AppTextStyles.fieldLabel),
        SizedBox(height: responsive.spacing(12)),
        _RadioOptionCard(
          emoji: '⚡',
          title: AppStrings.deliveryAsapTitle,
          subtitle: AppStrings.deliveryAsapSubtitle,
          isSelected: option == _DeliveryOption.asap,
          onTap: () => onSelect(_DeliveryOption.asap),
        ),
        SizedBox(height: responsive.spacing(8)),
        _RadioOptionCard(
          emoji: '📅',
          title: AppStrings.deliveryScheduleTitle,
          subtitle: AppStrings.deliveryScheduleSubtitle,
          isSelected: option == _DeliveryOption.schedule,
          onTap: () => onSelect(_DeliveryOption.schedule),
        ),
        if (option == _DeliveryOption.schedule) ...[
          SizedBox(height: responsive.spacing(16)),
          Text(AppStrings.date, style: AppTextStyles.fieldLabel),
          SizedBox(height: responsive.spacing(8)),
          TextField(controller: dateController, decoration: const InputDecoration(hintText: 'mm/dd/yyyy')),
          SizedBox(height: responsive.spacing(12)),
          Text(AppStrings.time, style: AppTextStyles.fieldLabel),
          SizedBox(height: responsive.spacing(8)),
          TextField(controller: timeController, decoration: const InputDecoration(hintText: '--:--:--')),
        ],
      ],
    );
  }
}

class _RadioOptionCard extends StatelessWidget {
  const _RadioOptionCard({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  final String emoji;
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(responsive.radius(8)),
      child: Container(
        padding: responsive.padding(all: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE8F5E9) : AppColors.surface,
          borderRadius: BorderRadius.circular(responsive.radius(8)),
        ),
        child: Row(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 28)),
            SizedBox(width: responsive.spacing(12)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.titleSmall),
                  Text(subtitle, style: AppTextStyles.bodySmall),
                ],
              ),
            ),
            Icon(
              isSelected ? Icons.radio_button_checked_rounded : Icons.radio_button_off_rounded,
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
              size: responsive.iconSize(20),
            ),
          ],
        ),
      ),
    );
  }
}

class _PaymentStep extends StatelessWidget {
  const _PaymentStep({
    required this.selectedPaymentId,
    required this.onSelect,
    required this.tipIndex,
    required this.tipOptions,
    required this.onTipSelect,
  });

  final String selectedPaymentId;
  final ValueChanged<String> onSelect;
  final int tipIndex;
  final List<String> tipOptions;
  final ValueChanged<int> onTipSelect;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.paymentMethodTitle, style: AppTextStyles.fieldLabel),
        SizedBox(height: responsive.spacing(12)),
        ...ProfileMockData.paymentMethods.map(
          (method) => PaymentMethodTile(
            method: method,
            isSelected: method.id == selectedPaymentId,
            onTap: () => onSelect(method.id),
          ),
        ),
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add_rounded, size: 16),
          label: Text(AppStrings.addNewCard),
          style: OutlinedButton.styleFrom(minimumSize: Size(double.infinity, responsive.size(48))),
        ),
        SizedBox(height: responsive.spacing(20)),
        Text(AppStrings.tipForDasher, style: AppTextStyles.titleSmall),
        Text(AppStrings.tipSubtitle, style: AppTextStyles.bodySmall),
        SizedBox(height: responsive.spacing(12)),
        Wrap(
          spacing: responsive.spacing(8),
          runSpacing: responsive.spacing(8),
          children: List.generate(tipOptions.length, (index) {
            final isSelected = index == tipIndex;
            return InkWell(
              onTap: () => onTipSelect(index),
              borderRadius: BorderRadius.circular(responsive.radius(8)),
              child: Container(
                padding: responsive.padding(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : AppColors.surface,
                  borderRadius: BorderRadius.circular(responsive.radius(8)),
                ),
                child: Text(
                  tipOptions[index],
                  style: AppTextStyles.bodySmall.copyWith(color: isSelected ? Colors.white : AppColors.textSecondary),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _ReviewStep extends StatelessWidget {
  const _ReviewStep({
    required this.address,
    required this.payment,
    required this.isAsap,
    required this.subtotal,
    required this.serviceFee,
    required this.tip,
    required this.total,
  });

  final dynamic address;
  final dynamic payment;
  final bool isAsap;
  final double subtotal;
  final double serviceFee;
  final double tip;
  final double total;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.orderReviewTitle, style: AppTextStyles.fieldLabel),
        SizedBox(height: responsive.spacing(12)),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppStrings.deliverTo, style: AppTextStyles.bodySmall),
              SizedBox(height: responsive.spacing(4)),
              Text(address.fullAddress, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w500)),
              SizedBox(height: responsive.spacing(4)),
              Text(
                isAsap ? '⚡ ASAP (25–35 min)' : '📅 Scheduled',
                style: AppTextStyles.bodySmall.copyWith(color: AppColors.primary),
              ),
            ],
          ),
        ),
        SizedBox(height: responsive.spacing(12)),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppStrings.paymentLabel, style: AppTextStyles.bodySmall),
              SizedBox(height: responsive.spacing(6)),
              Row(
                children: [
                  Icon(payment.icon, size: 18, color: AppColors.textPrimary),
                  SizedBox(width: responsive.spacing(8)),
                  Text(payment.label, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w500)),
                ],
              ),
              Divider(height: responsive.spacing(32)),
              Text(AppStrings.orderSummaryLabel, style: AppTextStyles.bodySmall),
              SizedBox(height: responsive.spacing(12)),
              _SummaryRow(label: AppStrings.subtotal, value: '${AppStrings.currencySymbol}${subtotal.toStringAsFixed(2)}'),
              _SummaryRow(label: AppStrings.deliveryFee, value: AppStrings.deliveryFeeFree),
              _SummaryRow(label: AppStrings.serviceFee, value: '${AppStrings.currencySymbol}${serviceFee.toStringAsFixed(2)}'),
              _SummaryRow(label: AppStrings.tipLabel, value: '${AppStrings.currencySymbol}${tip.toStringAsFixed(2)}'),
              Divider(height: responsive.spacing(24)),
              _SummaryRow(
                label: AppStrings.totalAmount,
                value: '${AppStrings.currencySymbol}${total.toStringAsFixed(2)}',
                isTotal: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value, this.isTotal = false});

  final String label;
  final String value;
  final bool isTotal;

  @override
  Widget build(BuildContext context) {
    final style = isTotal
        ? AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold, fontSize: 16)
        : AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(label, style: style), Text(value, style: style)],
      ),
    );
  }
}
