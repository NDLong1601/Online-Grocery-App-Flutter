abstract class LocaleEvent {}

class OnChangeLocaleEvent extends LocaleEvent {
  final String languageCode;
  final String countryCode;

  OnChangeLocaleEvent(this.languageCode, this.countryCode);
}

class OnInitLocaleEvent extends LocaleEvent {}
