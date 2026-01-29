import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:online_groceries_store_app/core/assets_gen/assets.gen.dart';
import 'package:online_groceries_store_app/core/extensions/context_extension.dart';
import 'package:online_groceries_store_app/core/utils/deep_link_manager.dart';
import 'package:online_groceries_store_app/di/injector.dart';
import 'package:online_groceries_store_app/domain/core/app_logger.dart';
import 'package:online_groceries_store_app/domain/entities/login_entity.dart';
import 'package:online_groceries_store_app/domain/repositories/local_storage_repository.dart';
import 'package:online_groceries_store_app/presentation/routes/deep_link_helper.dart';
import 'package:online_groceries_store_app/presentation/routes/route_name.dart';
import 'package:online_groceries_store_app/presentation/shared/app_background.dart';
import 'package:online_groceries_store_app/presentation/shared/app_button.dart';
import 'package:online_groceries_store_app/presentation/shared/app_text.dart';
import 'package:online_groceries_store_app/presentation/theme/app_colors.dart';
import 'package:online_groceries_store_app/presentation/theme/app_textstyle.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final ILocalStorage _localStorage = getIt<ILocalStorage>();
  final AppLogger _logger = getIt<AppLogger>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _logger.i("🔍 OnboardingScreen: Checking for access token...");

      /// Check if there's a pending deep link
      final hasPendingLink = DeepLinkManager.instance.hasPendingDeepLink();
      _logger.i("🔍 Has pending deep link: $hasPendingLink");

      final accessToken = await _localStorage.getAccessToken();
      accessToken.fold(
        (failure) {
          _logger.e(
            "Error getting access token",
            metadata: {'cause': failure.cause?.toString()},
          );
          return '';
        },
        (accessToken) {
          if (accessToken != null && accessToken.isNotEmpty) {
            _logger.i("✅ Access token found, navigating to BottomTab");

            final LoginEntity user = LoginEntity(
              id: 6,
              username: 'username',
              email: "email@gmail.com",
              fullName: 'fullName',
              gender: 'gender',
              image:
                  'https://cdn.dummyjson.com/products/images/smartphones/Vivo%20S1/thumbnail.png',
              accessToken: accessToken,
              refreshToken: 'refreshToken',
            );

            context.goNamed(RouteName.bottomTabName, extra: user);

            /// Check for pending deep link after navigation completes
            Future.delayed(const Duration(milliseconds: 800), () {
              final pendingDeepLink = DeepLinkManager.instance
                  .consumePendingDeepLink();
              if (pendingDeepLink != null) {
                _logger.i("🚀 Processing pending deep link: $pendingDeepLink");
                DeepLinkHelper.handleDeepLink(pendingDeepLink);
              } else {
                _logger.i("ℹ️ No pending deep link to process");
              }
            });
          } else {
            _logger.i("ℹ️ No access token, staying on onboarding");
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      background: Assets.images.imgOnboarding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: context.screenHeight * (370 / 896),
              bottom: 35 / 896 * context.screenHeight,
            ),
            child: Assets.images.imgCarotBg.image(),
          ),
          AppText(
            text: 'Welcome\nto our store',
            maxLines: 2,
            style: AppTextstyle.tsSemiboldSize48.copyWith(
              color: AppColors.white,
              decoration: TextDecoration.none,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, bottom: 40),
            child: AppText(
              text: 'Get your groceries in as fast as one hour',
              style: AppTextstyle.tsRegularSize16.copyWith(
                color: AppColors.white.withValues(alpha: 0.7),
                decoration: TextDecoration.none,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: AppButton(
              text: 'Get Started',
              onPressed: () {
                context.goNamed(RouteName.loginName);
              },
            ),
          ),
        ],
      ),
    );
  }
}
