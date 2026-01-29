import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_groceries_store_app/di/injector.dart';
import 'package:online_groceries_store_app/domain/core/app_logger.dart';
import 'package:online_groceries_store_app/domain/repositories/local_storage_repository.dart';
import 'package:online_groceries_store_app/presentation/bloc/locale/locale_event.dart';
import 'package:online_groceries_store_app/presentation/bloc/locale/locale_state.dart';

class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  ILocalStorage localStorage;
  LocaleBloc(this.localStorage) : super(const LocaleState()) {
    on<OnChangeLocaleEvent>(_onChangeLocaleEvent);
    on<OnInitLocaleEvent>(_onInitLocaleEvent);
  }

  Future<void> _onInitLocaleEvent(
    OnInitLocaleEvent event,
    Emitter<LocaleState> emit,
  ) async {
    try {
      final localeResult = await localStorage.getLocale();
      localeResult.fold(
        (failure) {
          getIt<AppLogger>().e(
            'LocaleBloc - _onInitLocaleEvent: Error getting locale - ${failure.cause}',
          );
        },
        (locale) {
          if (locale != null && locale.isNotEmpty) {
            if (locale == 'vi') {
              emit(state.copyWith(languageCode: 'vi', countryCode: 'VN'));
            } else {
              emit(state.copyWith(languageCode: 'en', countryCode: 'US'));
            }
          }
        },
      );
    } catch (e) {
      getIt<AppLogger>().e(
        'LocaleBloc - _onInitLocaleEvent: Error initializing locale - $e',
      );
    }
  }

  Future<void> _onChangeLocaleEvent(
    OnChangeLocaleEvent event,
    Emitter<LocaleState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          languageCode: event.languageCode,
          countryCode: event.countryCode,
        ),
      );

      // save to local storage
      await localStorage.setLocale(event.languageCode);
    } catch (e) {
      getIt<AppLogger>().e(
        'LocaleBloc - _onChangeLocaleEvent: Error changing locale - $e',
      );
    }
  }
}
