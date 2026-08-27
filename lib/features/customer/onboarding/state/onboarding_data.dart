import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_strings.dart';

class OnboardingPageModel {
  const OnboardingPageModel({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.buttonLabel,
  });

  final String title;
  final String subtitle;
  final String image;
  final String buttonLabel;
}

class OnboardingData {
  OnboardingData._();

  static const List<OnboardingPageModel> pages = [
    OnboardingPageModel(
      title: AppStrings.onboardTitle1,
      subtitle: AppStrings.onboardSubtitle1,
      image: AppAssets.onboardingShopLocalStores,
      buttonLabel: AppStrings.next,
    ),
    OnboardingPageModel(
      title: AppStrings.onboardTitle2,
      subtitle: AppStrings.onboardSubtitle2,
      image: AppAssets.onboardingFastDelivery,
      buttonLabel: AppStrings.next,
    ),
    OnboardingPageModel(
      title: AppStrings.onboardTitle3,
      subtitle: AppStrings.onboardSubtitle3,
      image: AppAssets.onboardingSecureCheckout,
      buttonLabel: AppStrings.next,
    ),
    OnboardingPageModel(
      title: AppStrings.onboardTitle5,
      subtitle: AppStrings.onboardSubtitle5,
      image: AppAssets.onboardingShortTermRental,
      buttonLabel: AppStrings.continueLabel,
    ),
    OnboardingPageModel(
      title: AppStrings.onboardTitle4,
      subtitle: AppStrings.onboardSubtitle4,
      image: AppAssets.onboardingTrackRealtime,
      buttonLabel: AppStrings.continueLabel,
    ),
  ];
}
