import 'package:chottu_link/chottu_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_groceries_store_app/core/utils/deep_link_manager.dart';
import 'package:online_groceries_store_app/di/injector.dart';
import 'package:online_groceries_store_app/domain/repositories/local_storage_repository.dart';
import 'package:online_groceries_store_app/l10n/app_localizations.dart';
import 'package:online_groceries_store_app/presentation/bloc/locale/locale_bloc.dart';
import 'package:online_groceries_store_app/presentation/bloc/locale/locale_event.dart';
import 'package:online_groceries_store_app/presentation/bloc/locale/locale_state.dart';
import 'package:online_groceries_store_app/presentation/routes/app_router.dart';
import 'package:online_groceries_store_app/presentation/routes/deep_link_helper.dart';

////
/// Khả năng / trình độ của bản thân = AI Power * Your Knowledge * Prompting Skill

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          LocaleBloc(getIt<ILocalStorage>())..add(OnInitLocaleEvent()),
      child: const AppEntryWidget(),
    );
  }
}

class AppEntryWidget extends StatefulWidget {
  const AppEntryWidget({super.key});

  @override
  State<AppEntryWidget> createState() => _AppEntryWidgetState();
}

class _AppEntryWidgetState extends State<AppEntryWidget> {
  @override
  void initState() {
    super.initState();
    _listenToDeepLinks();
  }

  void _listenToDeepLinks() {
    /// 🔗 Listen for incoming dynamic links
    /// This handles both:
    /// 1. Cold start: App killed → click link → opens app
    /// 2. Warm start: App running → click link
    ChottuLink.onLinkReceived.listen(
      (String link) {
        try {
          debugPrint("✅ ========================================");
          debugPrint("✅ Link Received: $link");
          debugPrint("✅ Widget mounted: $mounted");
          debugPrint("✅ ========================================");

          if (!mounted) {
            debugPrint("⚠️ Widget not mounted, cannot navigate.");
            return;
          }

          debugPrint("🔄 Step 1: Storing link in manager...");

          /// Store the link in DeepLinkManager
          /// It will be processed after OnboardingScreen completes its navigation
          DeepLinkManager.instance.setPendingDeepLink(link);
          debugPrint("📦 Step 2: Deep link stored in manager");

          debugPrint("🔄 Step 3: Calling _handleDeepLink...");
          _handleDeepLink(link);
          debugPrint("✅ Step 4: _handleDeepLink completed");
        } catch (e, stackTrace) {
          debugPrint("❌ Exception in _listenToDeepLinks: $e");
          debugPrint("❌ StackTrace: $stackTrace");
        }
      },
      onError: (error) {
        debugPrint("❌ Error receiving link: $error");
      },
    );
  }

  void _handleDeepLink(String link) {
    try {
      debugPrint("🚀 Inside _handleDeepLink, calling DeepLinkHelper...");
      DeepLinkHelper.handleDeepLink(link);
      debugPrint("✅ DeepLinkHelper.handleDeepLink completed");
    } catch (e, stackTrace) {
      debugPrint("❌ Exception in _handleDeepLink: $e");
      debugPrint("❌ StackTrace: $stackTrace");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleBloc, LocaleState>(
      builder: (context, state) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          routerConfig: AppRouter.router,
          locale: Locale(state.languageCode, state.countryCode),
          supportedLocales: const [Locale('en', 'US'), Locale('vi', 'VN')],
          localizationsDelegates: AppLocalizations.localizationsDelegates,
        );
      },
    );
  }
}
