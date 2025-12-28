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

  /// Define route name
  static const String splashName = 'splash';
  static const String loginName = 'login';
}
