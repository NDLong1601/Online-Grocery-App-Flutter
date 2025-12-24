import 'package:go_router/go_router.dart';
import 'package:online_groceries_store_app/presentation/routes/route_name.dart';
import 'package:online_groceries_store_app/presentation/screens/login/login_screen.dart';
import 'package:online_groceries_store_app/presentation/screens/splash/splash_screen.dart';

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
