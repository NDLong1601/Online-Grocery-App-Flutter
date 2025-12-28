import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final bool isLoading;
  final String apiErrorMessage;
  final bool isSuccess;

  const LoginState({
    this.isLoading = false,
    this.apiErrorMessage = '',
    this.isSuccess = false,
  });

  copyWith({
    bool? isLoading,
    String? apiErrorMessage,
    bool? isHidePassword,
    bool? isSuccess,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      apiErrorMessage: apiErrorMessage ?? this.apiErrorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [isLoading, apiErrorMessage, isSuccess];
}
