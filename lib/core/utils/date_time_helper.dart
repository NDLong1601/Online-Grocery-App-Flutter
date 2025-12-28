/// A utility class for handling date and time operations.
///
/// This class provides static methods for common date-time conversions
/// and manipulations, particularly focused on parsing and formatting
/// date-time strings in various formats.
///
/// All methods in this class are static and can be called directly
/// without instantiating the class.
///
/// Example usage:
/// ```dart
/// // Parse ISO 8601 string
/// final dateTime = DateTimeHelper.fromIso8601String("2023-12-25T10:30:00Z");
/// ```
class DateTimeHelper {
  /// string to DateTime from ISO 8601 string
  /// Parses an ISO 8601 string and returns a [DateTime] object.
  ///
  /// Takes an ISO 8601 formatted date-time string and converts it to a
  /// [DateTime] instance using Dart's built-in parsing functionality.
  ///
  /// Parameters:
  /// - [isoString]: A string in ISO 8601 format (e.g., "2023-12-25T10:30:00Z")
  ///
  /// Returns:
  /// A [DateTime] object representing the parsed date and time.
  ///
  /// Throws:
  /// - [FormatException] if the input string is not a valid ISO 8601 format.
  ///
  /// Example:
  /// ```dart
  /// final dateTime = DateTimeHelper.fromIso8601String("2023-12-25T10:30:00Z");
  /// print(dateTime); // 2023-12-25 10:30:00.000Z
  /// ```
  static DateTime fromIso8601String(String isoString) =>
      DateTime.parse(isoString);
}
