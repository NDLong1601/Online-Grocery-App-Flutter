import 'package:chottu_link/chottu_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_groceries_store_app/di/injector.dart';
import 'package:online_groceries_store_app/domain/repositories/local_storage_repository.dart';
import 'package:online_groceries_store_app/l10n/app_localizations.dart';
import 'package:online_groceries_store_app/presentation/bloc/locale/locale_bloc.dart';
import 'package:online_groceries_store_app/presentation/bloc/locale/locale_event.dart';
import 'package:online_groceries_store_app/presentation/bloc/locale/locale_state.dart';
import 'package:online_groceries_store_app/presentation/routes/app_router.dart';

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
    ChottuLink.onLinkReceived.listen((String link) {
      debugPrint(" ✅ Link Received: $link");

      /// Tip: ➡️ Navigate to a specific page or take action based on the link
    });
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
