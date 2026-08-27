import 'package:flutter/material.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../checkout/widgets/address_tile.dart';
import '../state/profile_mock_data.dart';

class AddressesScreen extends StatelessWidget {
  const AddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Scaffold(
      appBar: const CustomAppBar(title: AppStrings.myAddresses),
      body: SafeArea(
        child: Padding(
          padding: responsive.padding(all: 16),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: ProfileMockData.addresses
                      .map(
                        (address) => AddressTile(
                          address: address,
                          isSelected: address.isDefault,
                          onTap: () {},
                        ),
                      )
                      .toList(),
                ),
              ),
              AppButton(label: AppStrings.addAddress, icon: Icons.add_rounded, onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
