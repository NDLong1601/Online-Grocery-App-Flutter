import 'package:go_router/go_router.dart';
import 'package:online_groceries_store_app/domain/entities/login_entity.dart';
import 'package:online_groceries_store_app/presentation/routes/route_name.dart';
import 'package:online_groceries_store_app/presentation/screens/bottom_tab/bottom_tab.dart';
import 'package:online_groceries_store_app/presentation/screens/login/login_screen.dart';
import 'package:online_groceries_store_app/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:online_groceries_store_app/presentation/screens/order%20accepted/order_accepted_screen.dart';
import 'package:online_groceries_store_app/presentation/screens/product_detail/product_detail_screen.dart';
import 'package:online_groceries_store_app/presentation/screens/signup/signup_screen.dart';
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
    initialLocation: RouteName.onboardingPath,
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
      GoRoute(
        path: RouteName.signUpPath,
        name: RouteName.signUpName,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: RouteName.onboardingPath,
        name: RouteName.onboardingName,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: RouteName.orderAcceptedPath,
        name: RouteName.orderAcceptedName,
        builder: (context, state) {
          return OrderAcceptedScreen();
        },
      ),
      GoRoute(
        path: RouteName.bottomTabPath,
        name: RouteName.bottomTabName,
        builder: (context, state) {
          final user = state.extra as LoginEntity;
          return BottomTab(user: user);
        },
      ),
      GoRoute(
        path: RouteName.productDetailPath,
        name: RouteName.productDetailName,
        builder: (context, state) {
          final extra = state.extra;

          /// Handle both int (from normal navigation) and Map (from deep link)
          int productId;
          bool isFromDeepLink = false;

          if (extra is int) {
            productId = extra;
          } else if (extra is Map<String, dynamic>) {
            productId = extra["productId"] as int? ?? 0;
            isFromDeepLink = extra["isFromDeepLink"] as bool? ?? false;
          } else {
            productId = 0;
          }

          return ProductDetailScreen(
            productId: productId,
            isFromDeepLink: isFromDeepLink,
          );
        },
      ),
    ],
  );
}
