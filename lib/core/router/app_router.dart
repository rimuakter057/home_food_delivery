import 'package:go_router/go_router.dart';
import '../../features/customer/auth/screens/forgot_password_screen.dart';
import '../../features/customer/auth/screens/login_screen.dart';
import '../../features/customer/auth/screens/otp_verify_screen.dart';
import '../../features/customer/auth/screens/reset_password_screen.dart';
import '../../features/customer/auth/screens/role_landing_screen.dart';
import '../../features/customer/auth/screens/sign_up_screen.dart';
import '../../features/customer/cart/screens/cart_screen.dart';
import '../../features/customer/checkout/screens/checkout_screen.dart';
import '../../features/customer/favorites/screens/favorites_screen.dart';
import '../../features/customer/food_detail/screens/food_detail_screen.dart';
import '../../features/customer/location/screens/enable_location_screen.dart';
import '../../features/customer/location/screens/select_address_screen.dart';
import '../../features/customer/navigation/screens/main_shell_screen.dart';
import '../../features/customer/onboarding/screens/onboarding_screen.dart';
import '../../features/customer/orders/screens/order_history_screen.dart';
import '../../features/customer/orders/screens/order_success_screen.dart';
import '../../features/customer/orders/screens/order_tracking_screen.dart';
import '../../features/customer/orders/screens/rate_order_screen.dart';
import '../../features/customer/profile/screens/addresses_screen.dart';
import '../../features/customer/profile/screens/edit_profile_screen.dart';
import '../../features/customer/profile/screens/help_support_screen.dart';
import '../../features/customer/profile/screens/notifications_screen.dart';
import '../../features/customer/profile/screens/payment_methods_screen.dart';
import '../../features/customer/profile/screens/privacy_security_screen.dart';
import '../../features/customer/restaurant/screens/restaurant_detail_screen.dart';
import '../../features/customer/search/screens/search_screen.dart';
import '../../features/customer/splash/screens/splash_screen.dart';
import '../../features/host/navigation/screens/host_shell_screen.dart';
import '../../features/host/profile/screens/business_details_screen.dart';
import '../../features/host/profile/screens/host_edit_profile_screen.dart';
import '../../features/host/profile/screens/host_notifications_screen.dart';
import '../../features/host/profile/screens/personal_information_screen.dart';
import '../../features/host/properties/screens/add_property_screen.dart';
import '../../features/host/properties/screens/property_created_screen.dart';
import '../../features/host/properties/screens/property_detail_screen.dart';
import '../../features/host/requests/screens/delivery_approved_screen.dart';
import '../../features/host/requests/screens/delivery_window_screen.dart';
import '../../features/host/requests/screens/review_request_screen.dart';
import '../../features/shopper/application/screens/shopper_application_pending_screen.dart';
import '../../features/shopper/application/screens/shopper_application_submitted_screen.dart';
import '../../features/shopper/application/screens/shopper_basic_info_screen.dart';
import '../../features/shopper/application/screens/shopper_documents_screen.dart';
import '../../features/shopper/application/screens/shopper_vehicle_screen.dart';
import '../../features/shopper/earnings/screens/shopper_withdraw_screen.dart';
import '../../features/shopper/earnings/screens/shopper_withdrawal_requested_screen.dart';
import '../../features/shopper/navigation/screens/shopper_shell_screen.dart';
import '../../features/shopper/orders/screens/shopper_order_tracking_screen.dart';
import '../../features/shopper/orders/screens/shopper_report_issue_screen.dart';
import '../../features/shopper/profile/screens/shopper_edit_profile_screen.dart';
import '../../features/shopper/profile/screens/shopper_notifications_screen.dart';

/// Route path constants — reference these instead of hardcoding path
/// strings at call sites (`context.go(AppRoutes.home)`, not `context.go('/home')`).
class AppRoutes {
  AppRoutes._();

  static const splash = '/splash';
  static const onboarding = '/onboarding';
  static const roleLanding = '/role-landing';
  static const login = '/login';
  static const signup = '/signup';
  static const forgotPassword = '/forgot-password';
  static const otpVerify = '/otp-verify';
  static const resetPassword = '/reset-password';
  static const enableLocation = '/enable-location';
  static const selectAddress = '/select-address';
  static const home = '/home';
  static const search = '/search';
  static const restaurant = '/restaurant/:id';
  static const food = '/food/:id';
  static const cart = '/cart';
  static const checkout = '/checkout';
  static const orderSuccess = '/order-success/:orderId';
  static const orderTracking = '/order-tracking/:orderId';
  static const rateOrder = '/rate-order/:orderId';
  static const favorites = '/favorites';
  static const addresses = '/addresses';
  static const editProfile = '/edit-profile';
  static const paymentMethods = '/payment-methods';
  static const helpSupport = '/help-support';
  static const privacySecurity = '/privacy-security';
  static const notifications = '/notifications';
  static const orders = '/orders';

  // Host role
  static const hostLogin = '/host/login';
  static const hostSignup = '/host/signup';
  static const hostHome = '/host/home';
  static const hostAddProperty = '/host/properties/add';
  static const hostPropertyCreated = '/host/properties/created';
  static const hostPropertyDetail = '/host/properties/:id';
  static const hostReviewRequest = '/host/requests/:id/review';
  static const hostDeliveryWindow = '/host/requests/:id/delivery-window';
  static const hostDeliveryApproved = '/host/requests/:id/approved';
  static const hostPersonalInformation = '/host/profile/personal-information';
  static const hostBusinessDetails = '/host/profile/business-details';
  static const hostEditProfile = '/host/profile/edit';
  static const hostNotifications = '/host/profile/notifications';

  // Shopper role
  static const shopperLogin = '/shopper/login';
  static const shopperSignup = '/shopper/basic-info';
  static const shopperVehicle = '/shopper/vehicle';
  static const shopperDocuments = '/shopper/documents';
  static const shopperSubmitted = '/shopper/submitted';
  static const shopperPending = '/shopper/pending';
  static const shopperHome = '/shopper/home';
  static const shopperOrderTracking = '/shopper/orders/:id/tracking';
  static const shopperReportIssue = '/shopper/orders/:id/report-issue';
  static const shopperWithdraw = '/shopper/earnings/withdraw';
  static const shopperWithdrawalRequested = '/shopper/earnings/withdrawal-requested';
  static const shopperEditProfile = '/shopper/profile/edit';
  static const shopperNotifications = '/shopper/profile/notifications';

  static String restaurantPath(String id) => '/restaurant/$id';
  static String foodPath(String id) => '/food/$id';
  static String orderSuccessPath(String orderId) => '/order-success/$orderId';
  static String orderTrackingPath(String orderId) => '/order-tracking/$orderId';
  static String rateOrderPath(String orderId) => '/rate-order/$orderId';
  static String hostPropertyDetailPath(String id) => '/host/properties/$id';
  static String hostReviewRequestPath(String id) => '/host/requests/$id/review';
  static String hostDeliveryWindowPath(String id) => '/host/requests/$id/delivery-window';
  static String hostDeliveryApprovedPath(String id) => '/host/requests/$id/approved';
  static String shopperOrderTrackingPath(String id) => '/shopper/orders/$id/tracking';
  static String shopperReportIssuePath(String id) => '/shopper/orders/$id/report-issue';
}

class AppRouter {
  AppRouter._();

  static final router = GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(path: AppRoutes.splash, builder: (context, state) => const SplashScreen()),
      GoRoute(path: AppRoutes.onboarding, builder: (context, state) => const OnboardingScreen()),
      GoRoute(path: AppRoutes.roleLanding, builder: (context, state) => const RoleLandingScreen()),
      GoRoute(path: AppRoutes.login, builder: (context, state) => const LoginScreen()),
      GoRoute(path: AppRoutes.signup, builder: (context, state) => const SignUpScreen()),
      GoRoute(path: AppRoutes.forgotPassword, builder: (context, state) => const ForgotPasswordScreen()),
      GoRoute(path: AppRoutes.otpVerify, builder: (context, state) => const OtpVerifyScreen()),
      GoRoute(path: AppRoutes.resetPassword, builder: (context, state) => const ResetPasswordScreen()),
      GoRoute(path: AppRoutes.enableLocation, builder: (context, state) => const EnableLocationScreen()),
      GoRoute(path: AppRoutes.selectAddress, builder: (context, state) => const SelectAddressScreen()),
      GoRoute(path: AppRoutes.home, builder: (context, state) => const MainShellScreen()),
      GoRoute(path: AppRoutes.search, builder: (context, state) => const SearchScreen()),
      GoRoute(
        path: AppRoutes.restaurant,
        builder: (context, state) => RestaurantDetailScreen(restaurantId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: AppRoutes.food,
        builder: (context, state) => FoodDetailScreen(foodId: state.pathParameters['id']!),
      ),
      GoRoute(path: AppRoutes.cart, builder: (context, state) => const CartScreen()),
      GoRoute(path: AppRoutes.checkout, builder: (context, state) => const CheckoutScreen()),
      GoRoute(
        path: AppRoutes.orderSuccess,
        builder: (context, state) => OrderSuccessScreen(orderId: state.pathParameters['orderId']!),
      ),
      GoRoute(
        path: AppRoutes.orderTracking,
        builder: (context, state) => OrderTrackingScreen(orderId: state.pathParameters['orderId']!),
      ),
      GoRoute(
        path: AppRoutes.rateOrder,
        builder: (context, state) => RateOrderScreen(orderId: state.pathParameters['orderId']!),
      ),
      GoRoute(path: AppRoutes.orders, builder: (context, state) => const OrderHistoryScreen()),
      GoRoute(path: AppRoutes.favorites, builder: (context, state) => const FavoritesScreen()),
      GoRoute(path: AppRoutes.addresses, builder: (context, state) => const AddressesScreen()),
      GoRoute(path: AppRoutes.editProfile, builder: (context, state) => const EditProfileScreen()),
      GoRoute(path: AppRoutes.paymentMethods, builder: (context, state) => const PaymentMethodsScreen()),
      GoRoute(path: AppRoutes.helpSupport, builder: (context, state) => const HelpSupportScreen()),
      GoRoute(path: AppRoutes.privacySecurity, builder: (context, state) => const PrivacySecurityScreen()),
      GoRoute(path: AppRoutes.notifications, builder: (context, state) => const NotificationsScreen()),
      GoRoute(
        path: AppRoutes.hostLogin,
        builder: (context, state) => const LoginScreen(
          successRoute: AppRoutes.hostHome,
          signUpRoute: AppRoutes.hostSignup,
        ),
      ),
      GoRoute(
        path: AppRoutes.hostSignup,
        builder: (context, state) => const SignUpScreen(
          successRoute: AppRoutes.hostHome,
          signInRoute: AppRoutes.hostLogin,
        ),
      ),
      GoRoute(path: AppRoutes.hostHome, builder: (context, state) => const HostShellScreen()),
      GoRoute(path: AppRoutes.hostAddProperty, builder: (context, state) => const AddPropertyScreen()),
      GoRoute(path: AppRoutes.hostPropertyCreated, builder: (context, state) => const PropertyCreatedScreen()),
      GoRoute(
        path: AppRoutes.hostPropertyDetail,
        builder: (context, state) => PropertyDetailScreen(propertyId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: AppRoutes.hostReviewRequest,
        builder: (context, state) => ReviewRequestScreen(requestId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: AppRoutes.hostDeliveryWindow,
        builder: (context, state) => DeliveryWindowScreen(requestId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: AppRoutes.hostDeliveryApproved,
        builder: (context, state) => DeliveryApprovedScreen(requestId: state.pathParameters['id']!),
      ),
      GoRoute(path: AppRoutes.hostPersonalInformation, builder: (context, state) => const PersonalInformationScreen()),
      GoRoute(path: AppRoutes.hostBusinessDetails, builder: (context, state) => const BusinessDetailsScreen()),
      GoRoute(path: AppRoutes.hostEditProfile, builder: (context, state) => const HostEditProfileScreen()),
      GoRoute(path: AppRoutes.hostNotifications, builder: (context, state) => const HostNotificationsScreen()),
      GoRoute(
        path: AppRoutes.shopperLogin,
        builder: (context, state) => const LoginScreen(
          successRoute: AppRoutes.shopperHome,
          signUpRoute: AppRoutes.shopperSignup,
          backRoute: AppRoutes.roleLanding,
        ),
      ),
      GoRoute(path: AppRoutes.shopperSignup, builder: (context, state) => const ShopperBasicInfoScreen()),
      GoRoute(path: AppRoutes.shopperVehicle, builder: (context, state) => const ShopperVehicleScreen()),
      GoRoute(path: AppRoutes.shopperDocuments, builder: (context, state) => const ShopperDocumentsScreen()),
      GoRoute(path: AppRoutes.shopperSubmitted, builder: (context, state) => const ShopperApplicationSubmittedScreen()),
      GoRoute(path: AppRoutes.shopperPending, builder: (context, state) => const ShopperApplicationPendingScreen()),
      GoRoute(path: AppRoutes.shopperHome, builder: (context, state) => const ShopperShellScreen()),
      GoRoute(
        path: AppRoutes.shopperOrderTracking,
        builder: (context, state) => ShopperOrderTrackingScreen(orderId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: AppRoutes.shopperReportIssue,
        builder: (context, state) => ShopperReportIssueScreen(orderId: state.pathParameters['id']!),
      ),
      GoRoute(path: AppRoutes.shopperWithdraw, builder: (context, state) => const ShopperWithdrawScreen()),
      GoRoute(path: AppRoutes.shopperWithdrawalRequested, builder: (context, state) => const ShopperWithdrawalRequestedScreen()),
      GoRoute(path: AppRoutes.shopperEditProfile, builder: (context, state) => const ShopperEditProfileScreen()),
      GoRoute(path: AppRoutes.shopperNotifications, builder: (context, state) => const ShopperNotificationsScreen()),
    ],
  );
}
