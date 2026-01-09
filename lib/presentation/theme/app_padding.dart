import 'package:flutter/material.dart';

/// A utility class that defines consistent padding values used throughout the application.
///
/// This class provides standardized padding constants for various UI elements,
/// ensuring consistent spacing and visual hierarchy across the app.
///
/// ## Usage Examples:
///
/// **Using padding constants directly:**
/// ```dart
/// Padding(
///   padding: EdgeInsets.all(AppPadding.p16),
///   child: Text('Hello World'),
/// )
/// ```

class AppPadding {
  static const double p4 = 4.0;
  static const double p8 = 8.0;
  static const double p12 = 12.0;
  static const double p16 = 16.0;
  static const double p20 = 20.0;
  static const double p24 = 24.0;
  static const double p28 = 28.0;
  static const double p32 = 32.0;

  /// Horizontal padding with 16.0
  static const EdgeInsets paddingH16 = EdgeInsets.symmetric(horizontal: p16);

  /// Vertical padding with 16.0
  static const EdgeInsets paddingV16 = EdgeInsets.symmetric(vertical: p16);

  /// All-sided padding with 16.0
  static const EdgeInsets paddingAll16 = EdgeInsets.all(p16);

  /// Horizontal padding with 8.0
  static const EdgeInsets paddingH8 = EdgeInsets.symmetric(horizontal: p8);

  /// Vertical padding with 8.0
  static const EdgeInsets paddingV8 = EdgeInsets.symmetric(vertical: p8);

  /// All-sided padding with 8.0
  static const EdgeInsets paddingAll8 = EdgeInsets.all(p8);

  /// Horizontal padding with 12.0
  static const EdgeInsets paddingH12 = EdgeInsets.symmetric(horizontal: p12);

  /// Vertical padding with 12.0
  static const EdgeInsets paddingV12 = EdgeInsets.symmetric(vertical: p12);

  /// All-sided padding with 12.0
  static const EdgeInsets paddingAll12 = EdgeInsets.all(p12);

  /// Horizontal padding with 20.0
  static const EdgeInsets paddingH20 = EdgeInsets.symmetric(horizontal: p20);

  /// Vertical padding with 20.0
  static const EdgeInsets paddingV20 = EdgeInsets.symmetric(vertical: p20);

  /// All-sided padding with 20.0
  static const EdgeInsets paddingAll20 = EdgeInsets.all(p20);

  /// Horizontal padding with 24.0
  static const EdgeInsets paddingH24 = EdgeInsets.symmetric(horizontal: p24);

  /// Vertical padding with 24.0
  static const EdgeInsets paddingV24 = EdgeInsets.symmetric(vertical: p24);

  /// All-sided padding with 24.0
  static const EdgeInsets paddingAll24 = EdgeInsets.all(p24);

  /// Only left padding with 16.0
  static const EdgeInsets paddingLeft16 = EdgeInsets.only(left: p16);

  /// Only right padding with 16.0
  static const EdgeInsets paddingRight16 = EdgeInsets.only(right: p16);

  /// Only top padding with 16.0
  static const EdgeInsets paddingTop16 = EdgeInsets.only(top: p16);

  /// Only bottom padding with 16.0
  static const EdgeInsets paddingBottom16 = EdgeInsets.only(bottom: p16);
}
