import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_groceries_store_app/di/injector.dart';
import 'package:online_groceries_store_app/domain/repositories/local_storage_repository.dart';
import 'package:online_groceries_store_app/l10n/app_localizations.dart';
import 'package:online_groceries_store_app/presentation/bloc/locale/locale_bloc.dart';
import 'package:online_groceries_store_app/presentation/bloc/locale/locale_event.dart';
import 'package:online_groceries_store_app/presentation/bloc/locale/locale_state.dart';
import 'package:online_groceries_store_app/presentation/routes/app_router.dart';

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

class AppEntryWidget extends StatelessWidget {
  const AppEntryWidget({super.key});

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
