import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../dashboard/state/host_mock_data.dart';

/// The "Edit Profile" form (Figma node 521:7697): full name, phone, email,
/// date of birth, over the host's rounded avatar photo.
class HostEditProfileScreen extends StatefulWidget {
  const HostEditProfileScreen({super.key});

  @override
  State<HostEditProfileScreen> createState() => _HostEditProfileScreenState();
}

class _HostEditProfileScreenState extends State<HostEditProfileScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;
  final _dobController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final profile = HostMockData.profile;
    _nameController = TextEditingController(text: profile.ownerName);
    _phoneController = TextEditingController(text: profile.phone);
    _emailController = TextEditingController(text: profile.email);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _dobController.dispose();
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
                  Text(AppStrings.editProfile, style: AppTextStyles.titleLarge),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: responsive.padding(horizontal: 16, vertical: 16),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: responsive.size(96),
                          height: responsive.size(96),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(color: const Color(0x4D2E7D32), blurRadius: responsive.spacing(8), offset: Offset(0, responsive.spacing(4))),
                            ],
                          ),
                          child: Center(
                            child: Container(
                              width: responsive.size(64),
                              height: responsive.size(64),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: const Color(0xFFE0E0E0), width: 2),
                              ),
                              child: ClipOval(
                                child: Image.asset(AppAssets.hostAvatar, fit: BoxFit.cover),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: responsive.size(32),
                            height: responsive.size(32),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(color: const Color(0x33000000), blurRadius: responsive.spacing(4), offset: Offset(0, responsive.spacing(2))),
                              ],
                            ),
                            child: Icon(Icons.camera_alt_outlined, size: responsive.iconSize(14), color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: responsive.spacing(12)),
                    Text('Tap to change photo', style: AppTextStyles.bodySmall),
                    SizedBox(height: responsive.spacing(12)),
                    AppTextField(label: AppStrings.hostFullName, hint: AppStrings.hostFullName, controller: _nameController),
                    SizedBox(height: responsive.spacing(12)),
                    AppTextField(label: AppStrings.hostPhone, hint: AppStrings.hostPhone, controller: _phoneController, keyboardType: TextInputType.phone),
                    SizedBox(height: responsive.spacing(12)),
                    AppTextField(label: AppStrings.hostEmailAddress, hint: AppStrings.hostEmailAddress, controller: _emailController, keyboardType: TextInputType.emailAddress),
                    SizedBox(height: responsive.spacing(12)),
                    AppTextField(label: AppStrings.hostDateOfBirth, hint: 'mm/dd/yyyy', controller: _dobController),
                    SizedBox(height: responsive.spacing(24)),
                    AppButton(label: AppStrings.hostSaveChanges, large: true, onPressed: () => context.pop()),
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
