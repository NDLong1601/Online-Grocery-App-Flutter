/// A utility class that provides helper methods for working with double values.
///
/// This class contains static methods for common double operations including
/// type conversion, approximate equality comparison, and value clamping.
///
/// All methods are static and the class is not meant to be instantiated.
///
/// Example usage:
/// ```dart
/// // Convert various types to double
/// double price = DoubleHelper.toDouble("19.99");
///
/// // Compare floating-point numbers safely
/// bool isEqual = DoubleHelper.isApproximatelyEqual(0.1 + 0.2, 0.3);
///
/// // Ensure values stay within bounds
/// double clampedValue = DoubleHelper.clamp(temperature, -10.0, 50.0);
/// ```
class DoubleHelper {
  /// Converts a dynamic value to a double.
  ///
  /// This method handles type conversion from various types to double:
  /// - If the value is already a [double], returns it directly
  /// - If the value is an [int], converts it to double using [int.toDouble]
  /// - If the value is a [String], attempts to parse it using [double.tryParse]
  /// - For any other type, returns 0.0 as default
  ///
  /// Parameters:
  /// - [value]: The dynamic value to convert to double
  ///
  /// Returns:
  /// A [double] representation of the input value, or 0.0 if conversion fails
  ///
  /// Example:
  /// ```dart
  /// double result1 = DoubleHelper.toDouble(42);      // Returns 42.0
  /// double result2 = DoubleHelper.toDouble("3.14");  // Returns 3.14
  /// double result3 = DoubleHelper.toDouble("abc");   // Returns 0.0
  /// double result4 = DoubleHelper.toDouble(null);    // Returns 0.0
  /// ```
  static double toDouble(dynamic value) {
    if (value is double) {
      return value;
    } else if (value is int) {
      return value.toDouble();
    } else if (value is String) {
      return double.tryParse(value) ?? 0.0;
    } else {
      return 0.0;
    }
  }

  /// Checks if two double values are approximately equal within a specified tolerance.
  ///
  /// This method is useful for comparing floating-point numbers where exact equality
  /// might not be reliable due to precision issues.
  ///
  /// Parameters:
  /// - [a]: The first double value to compare
  /// - [b]: The second double value to compare
  /// - [epsilon]: The tolerance value for comparison (default: 0.0001)
  ///
  /// Returns:
  /// - `true` if the absolute difference between [a] and [b] is less than [epsilon]
  /// - `false` otherwise
  ///
  /// Example:
  /// ```dart
  /// bool result = DoubleHelper.isApproximatelyEqual(0.1 + 0.2, 0.3);
  /// // Returns true, even though 0.1 + 0.2 != 0.3 in floating-point arithmetic
  /// ```
  static bool isApproximatelyEqual(
    double a,
    double b, [
    double epsilon = 0.0001,
  ]) {
    return (a - b).abs() < epsilon;
  }

  /// Clamps a double value between a minimum and maximum range.
  ///
  /// Returns [min] if [value] is less than [min],
  /// returns [max] if [value] is greater than [max],
  /// otherwise returns [value] unchanged.
  ///
  /// Parameters:
  /// - [value]: The value to be clamped
  /// - [min]: The minimum allowed value
  /// - [max]: The maximum allowed value
  ///
  /// Returns the clamped value within the specified range.
  ///
  /// Example:
  /// ```dart
  /// double result = clamp(15.0, 10.0, 20.0); // Returns 15.0
  /// double result2 = clamp(5.0, 10.0, 20.0); // Returns 10.0
  /// double result3 = clamp(25.0, 10.0, 20.0); // Returns 20.0
  /// ```
  static double clamp(double value, double min, double max) {
    if (value < min) return min;
    if (value > max) return max;
    return value;
  }
}
