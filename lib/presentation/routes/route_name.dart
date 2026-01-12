/// A utility class that defines route paths and names for the application's navigation system.
///
/// This class provides centralized constants for managing navigation routes,
/// ensuring consistency across the application when defining and referencing routes.
///
/// The class contains two main categories:
/// - Path constants: Define the actual URL paths used for navigation
/// - Name constants: Define human-readable names for routes
///
/// Example usage:
/// ```dart
/// GoRouter.of(context).goNamed(RouteName.splashName);
/// // or
/// GoRouter.of(context).go(RouteName.splashPath);
/// ```
class RouteName {
  /// Define path
  static const String splashPath = '/splash';
  static const String loginPath = '/login';
  static const String shopPath = '/shop';
  static const String explorePath = '/explore';
  static const String cartPath = 'cart';
  static const String favouritePath = 'favourite';
  static const String accountPath = '/account';
  static const String bottomTabPath = '/bottom-tab';
  static const String onboardingPath = '/onboarding';
  static const String signUpPath = '/sign-up';

  /// Define route name
  static const String splashName = 'splash';
  static const String loginName = 'login';
  static const String shopName = 'shop';
  static const String exploreName = 'explore';
  static const String cartName = 'cart';
  static const String favouriteName = 'favourite';
  static const String accountName = 'account';
  static const String bottomTabName = 'bottom-tab';
  static const String onboardingName = 'onboarding';
  static const String signUpName = 'sign-up';
}
