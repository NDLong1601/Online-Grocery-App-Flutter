import 'package:flutter/material.dart';

/// A utility class that defines consistent text styles and typography constants
/// for the application.
///
/// This class provides:
/// - Font family configuration using 'Poppins'
/// - Standardized font sizes (small, medium, large)
/// - Pre-defined TextStyle configurations for common use cases
///
/// Example usage:
/// ```dart
/// Text(
///   'Hello World',
///   style: AppTextstyle.tsRegularSize16Medium,
/// )
/// ```
class AppTextstyle {
  /// The default font family used throughout the application
  static const String fontFamily = 'Gilroy';

  // ==================== FontWeight.w600 (Semibold) ====================

  /// Semibold text style with size 48.0
  static const tsSemiboldSize48 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 48.0,
    fontWeight: FontWeight.w600,
  );

  /// Semibold text style with size 28.0
  static const tsSemiboldSize28 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28.0,
    fontWeight: FontWeight.w600,
  );

  /// Semibold text style with size 26.0
  static const tsSemiboldSize26 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 26.0,
    fontWeight: FontWeight.w600,
  );

  /// Semibold text style with size 24.0
  static const tsSemiboldSize24 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24.0,
    fontWeight: FontWeight.w600,
  );

  /// Semibold text style with size 18.0
  static const tsSemiboldSize18 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
  );

  /// Semibold text style with size 16.0
  static const tsSemiboldSize16 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
  );

  /// Semibold text style with size 14.0
  static const tsSemiboldSize14 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
  );

  /// Semibold text style with size 12.0
  static const tsSemiboldSize12 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12.0,
    fontWeight: FontWeight.w600,
  );

  /// Semibold text style with size 9.0
  static const tsSemiboldSize9 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 9.0,
    fontWeight: FontWeight.w600,
  );

  // ==================== FontWeight.w400 (Regular) ====================

  /// Regular text style with size 20.0
  static const tsRegularSize20 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20.0,
    fontWeight: FontWeight.w400,
  );

  /// Regular text style with size 18.0
  static const tsRegularSize18 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18.0,
    fontWeight: FontWeight.w400,
  );

  /// Regular text style with size 16.0
  static const tsRegularSize16 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
  );

  /// Regular text style with size 14.0
  static const tsRegularSize14 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
  );

  /// Regular text style with size 13.0
  static const tsRegularSize13 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13.0,
    fontWeight: FontWeight.w400,
  );
}

