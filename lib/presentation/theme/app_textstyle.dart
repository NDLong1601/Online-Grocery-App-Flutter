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
  static const String fontFamily = 'Poppins';

  /// Small font size (12.0) - typically used for captions and helper text
  static const double fontSizeSmall = 12.0;

  /// Medium font size (16.0) - typically used for body text
  static const double fontSizeMedium = 16.0;

  /// Large font size (20.0) - typically used for headings and titles
  static const double fontSizeLarge = 20.0;

  /// Regular weight text style with medium font size (16.0)
  ///
  /// Uses FontWeight.w400 (normal) and is suitable for body text
  static const tsRegularSize16Medium = TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSizeMedium,
    fontWeight: FontWeight.w400,
  );

  /// Bold text style with large font size (20.0)
  ///
  /// Uses FontWeight.w700 (bold) and is suitable for headings and titles
  static const tsBoldSize20Large = TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSizeLarge,
    fontWeight: FontWeight.w700,
  );
}
