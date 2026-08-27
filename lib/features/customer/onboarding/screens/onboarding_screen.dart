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
import '../../../../core/widgets/page_indicator_dots.dart';
import '../state/onboarding_data.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goToRoleLanding() {
    context.go(AppRoutes.roleLanding);
  }

  void _handleNext() {
    if (_currentPage == OnboardingData.pages.length - 1) {
      _goToRoleLanding();
    } else {
      _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    }
  }

  void _handleBack() {
    if (_currentPage > 0) {
      _controller.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-0.5, -1),
            end: Alignment(0.5, 1),
            colors: AppColors.onboardingGradient,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: responsive.padding(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: _handleBack,
                      borderRadius: BorderRadius.circular(responsive.radius(12)),
                      child: Padding(
                        padding: responsive.padding(all: 4),
                        child: SvgPicture.asset(
                          AppAssets.chevronBack,
                          width: responsive.iconSize(24),
                          height: responsive.iconSize(24),
                          colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: _goToRoleLanding,
                      borderRadius: BorderRadius.circular(responsive.radius(12)),
                      child: Container(
                        padding: responsive.padding(horizontal: 18, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.06),
                          borderRadius: BorderRadius.circular(responsive.radius(12)),
                        ),
                        child: Text(
                          AppStrings.skip,
                          style: AppTextStyles.labelSmall.copyWith(color: AppColors.primary),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: OnboardingData.pages.length,
                  onPageChanged: (index) => setState(() => _currentPage = index),
                  itemBuilder: (context, index) {
                    final page = OnboardingData.pages[index];
                    return SingleChildScrollView(
                      padding: responsive.padding(horizontal: 24, vertical: 8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(page.image, height: responsive.size(280), fit: BoxFit.contain),
                          SizedBox(height: responsive.spacing(12)),
                          Text(
                            page.title,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.headlineLarge.copyWith(color: AppColors.primaryDark),
                          ),
                          SizedBox(height: responsive.spacing(8)),
                          Text(
                            page.subtitle,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.fieldLabel.copyWith(color: AppColors.onboardingSubtitle, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              PageIndicatorDots(count: OnboardingData.pages.length, activeIndex: _currentPage),
              Padding(
                padding: responsive.padding(all: 24),
                child: AppButton(
                  label: OnboardingData.pages[_currentPage].buttonLabel,
                  large: true,
                  onPressed: _handleNext,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
