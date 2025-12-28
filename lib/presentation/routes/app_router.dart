import 'package:go_router/go_router.dart';
import 'package:online_groceries_store_app/presentation/routes/route_name.dart';
import 'package:online_groceries_store_app/presentation/screens/login/login_screen.dart';
import 'package:online_groceries_store_app/presentation/screens/splash/splash_screen.dart';

/// A centralized router configuration class for the application using GoRouter.
///
/// This class defines all the navigation routes and their corresponding screens
/// for the grocery app. It uses the GoRouter package for declarative routing
/// and navigation management.
///
/// The router is configured with:
/// - Initial location set to the splash screen
/// - Route definitions with paths, names, and screen builders
///
/// Usage:
/// ```dart
/// MaterialApp.router(
///   routerConfig: AppRouter.router,
/// )
/// ```
class AppRouter {
  static final router = GoRouter(
    initialLocation: RouteName.splashPath,
    routes: [
      GoRoute(
        path: RouteName.splashPath,
        name: RouteName.splashName,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RouteName.loginPath,
        name: RouteName.loginName,
        builder: (context, state) => const LoginScreen(),
      ),
    ],
  );
}
