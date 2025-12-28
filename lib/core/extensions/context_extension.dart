import 'package:flutter/material.dart';
import 'package:online_groceries_store_app/l10n/app_localizations.dart';

/// Extension on [BuildContext] that provides convenient access to common UI properties and utilities.
///
/// This extension adds shorthand methods to access frequently used properties from the context,
/// such as screen dimensions, theme data, and localization resources.
///
/// Example usage:
/// ```dart
/// Widget build(BuildContext context) {
///   return Container(
///     width: context.screenWidth * 0.8,
///     height: context.screenHeight * 0.5,
///     color: context.surfaceColor,
///     child: Text(
///       'Hello World',
///       style: context.textTheme.headlineMedium,
///     ),
///   );
/// }
/// ```
/// context extensions based on BuildContext
extension ContextExtension on BuildContext {
  /// screen width
  double get screenWidth => MediaQuery.of(this).size.width;

  /// screen height
  double get screenHeight => MediaQuery.of(this).size.height;

  /// Theme
  ThemeData get theme => Theme.of(this);

  /// TextTheme
  TextTheme get textTheme => theme.textTheme;

  /// ColorScheme
  ColorScheme get colorScheme => theme.colorScheme;

  /// ColorScheme surface
  Color get surfaceColor => colorScheme.surface;

  /// get appLocalizations
  AppLocalizations? get appLocalizations => AppLocalizations.of(this);
}
