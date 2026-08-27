import 'package:flutter/material.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../checkout/widgets/payment_method_tile.dart';
import '../state/profile_mock_data.dart';

class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Scaffold(
      appBar: const CustomAppBar(title: AppStrings.paymentMethods),
      body: SafeArea(
        child: Padding(
          padding: responsive.padding(all: 16),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: ProfileMockData.paymentMethods
                      .map(
                        (method) => PaymentMethodTile(
                          method: method,
                          isSelected: method.isDefault,
                          onTap: () {},
                        ),
                      )
                      .toList(),
                ),
              ),
              AppButton(label: AppStrings.addPaymentMethod, icon: Icons.add_rounded, onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
