import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_groceries_store_app/di/injector.dart';
import 'package:online_groceries_store_app/domain/core/app_logger.dart';
import 'package:online_groceries_store_app/domain/repositories/local_storage_repository.dart';
import 'package:online_groceries_store_app/domain/usecase/login_user_usecase.dart';
import 'package:online_groceries_store_app/domain/value_object/login_credentials.dart';
import 'package:online_groceries_store_app/presentation/bloc/login/login_event.dart';
import 'package:online_groceries_store_app/presentation/bloc/login/login_state.dart';
import 'package:online_groceries_store_app/presentation/error/failure_mapper.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUserUsecase _loginUsecase;
  final ILocalStorage _localStorage;
  final FailureMapper _failureMapper;

  LoginBloc(this._loginUsecase, this._localStorage, this._failureMapper)
    : super(const LoginState()) {
    on<OnLoginEvent>((event, emit) async {
      await _onLoginEvent(event, emit);
    });
    on<OnClearLoginErrorMessage>(_onClearLoginErrorMessage);
  }

  Future<void> _onLoginEvent(
    OnLoginEvent event,
    Emitter<LoginState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      final result = await _loginUsecase.call(
        LoginCredentials(
          username: event.username,
          password: event.password,
          expiresInMins: 30,
        ),
      );
      await result.fold(
        (failure) {
          emit(
            state.copyWith(
              apiErrorMessage: _failureMapper.mapFailureToMessage(failure),
            ),
          );
        },
        (success) async {
          await _localStorage.setAccessToken(success.accessToken);

          /// save refresh token
          final accessToken = await _localStorage.getAccessToken();
          getIt<AppLogger>().i(
            "accessToken",
            metadata: {
              'accessToken': accessToken.fold(
                (failure) => failure.cause?.toString(),
                (data) => data ?? '',
              ),
            },
          );
          emit(state.copyWith(isSuccess: true));
        },
      );
    } catch (e) {
      emit(state.copyWith(apiErrorMessage: e.toString()));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  void _onClearLoginErrorMessage(
    OnClearLoginErrorMessage event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(apiErrorMessage: ''));
  }
}
