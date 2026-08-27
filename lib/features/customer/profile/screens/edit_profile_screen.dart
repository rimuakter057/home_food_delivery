import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../state/profile_mock_data.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    final user = ProfileMockData.currentUser;
    _nameController = TextEditingController(text: user.name);
    _emailController = TextEditingController(text: user.email);
    _phoneController = TextEditingController(text: user.phone);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Scaffold(
      appBar: const CustomAppBar(title: AppStrings.editProfile),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: responsive.padding(all: 16),
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: responsive.size(96),
                          height: responsive.size(96),
                          decoration: BoxDecoration(color: ProfileMockData.currentUser.avatarColor, shape: BoxShape.circle),
                          child: Icon(Icons.person, color: Colors.white, size: responsive.iconSize(44)),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: responsive.size(32),
                            height: responsive.size(32),
                            decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                            child: Icon(Icons.camera_alt_outlined, color: Colors.white, size: responsive.iconSize(14)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: responsive.spacing(8)),
                    Text('Tap to change photo', style: AppTextStyles.bodySmall),
                  ],
                ),
              ),
              SizedBox(height: responsive.spacing(24)),
              AppTextField(
                label: AppStrings.fullName,
                hint: AppStrings.enterFullName,
                controller: _nameController,
                prefixIcon: Icons.person_outline_rounded,
              ),
              SizedBox(height: responsive.spacing(16)),
              AppTextField(
                label: AppStrings.email,
                hint: AppStrings.enterEmail,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icons.email_outlined,
              ),
              SizedBox(height: responsive.spacing(16)),
              AppTextField(
                label: AppStrings.phoneNumber,
                hint: AppStrings.enterPhoneNumber,
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                prefixIcon: Icons.call_outlined,
              ),
              SizedBox(height: responsive.spacing(28)),
              AppButton(label: AppStrings.save, onPressed: () => context.pop()),
            ],
          ),
        ),
      ),
    );
  }
}
