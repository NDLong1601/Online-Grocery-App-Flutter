import 'package:equatable/equatable.dart';

class LocaleState extends Equatable {
  final String languageCode;
  final String countryCode;

  const LocaleState({this.languageCode = 'en', this.countryCode = 'US'});

  LocaleState copyWith({String? languageCode, String? countryCode}) {
    return LocaleState(
      languageCode: languageCode ?? this.languageCode,
      countryCode: countryCode ?? this.countryCode,
    );
  }

  @override
  List<Object?> get props => [languageCode, countryCode];
}
