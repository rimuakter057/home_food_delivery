import 'package:flutter_test/flutter_test.dart';

import 'package:home_food_delivery/core/constants/app_strings.dart';
import 'package:home_food_delivery/features/customer/onboarding/screens/onboarding_screen.dart';
import 'package:home_food_delivery/main.dart';

void main() {
  testWidgets('Splash screen shows the app name and moves to onboarding', (tester) async {
    await tester.pumpWidget(const HomeFoodDeliveryApp());

    expect(find.text(AppStrings.appName), findsOneWidget);

    await tester.pumpAndSettle(const Duration(seconds: 3));

    expect(find.byType(OnboardingScreen), findsOneWidget);
    expect(find.text(AppStrings.onboardTitle1), findsOneWidget);
  });

  testWidgets('Onboarding can be skipped straight to the role landing screen', (tester) async {
    await tester.pumpWidget(const HomeFoodDeliveryApp());
    await tester.pumpAndSettle(const Duration(seconds: 3));

    await tester.tap(find.text(AppStrings.skip));
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.becomeCustomer), findsOneWidget);
  });
}
