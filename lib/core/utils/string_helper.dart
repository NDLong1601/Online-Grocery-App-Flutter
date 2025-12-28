/// A utility class that provides common string manipulation and validation methods.
///
/// This class contains static methods for performing various operations on strings
/// such as validation, formatting, and transformation. All methods are static
/// and can be called directly on the class without instantiation.
///
/// Example usage:
/// ```dart
/// // Check if string is null or empty
/// bool isEmpty = StringHelper.isNullOrEmpty(myString);
///
/// // Capitalize first letter
/// String capitalized = StringHelper.capitalize('hello world');
///
/// // Truncate with ellipsis
/// String truncated = StringHelper.truncateWithEllipsis('Long text here', 10);
///
/// // Reverse string
/// String reversed = StringHelper.reverse('hello');
/// ```
class StringHelper {
  /// Checks if the given string is null or empty.
  /// Checks if a string is null or empty.
  ///
  /// Returns `true` if the provided string [str] is either `null` or has a length
  /// of zero (empty string). Returns `false` otherwise.
  ///
  /// Parameters:
  /// * [str] - The string to check, can be null
  ///
  /// Returns:
  /// * `bool` - `true` if the string is null or empty, `false` otherwise
  ///
  /// Example:
  /// ```dart
  /// StringHelper.isNullOrEmpty(null); // returns true
  /// StringHelper.isNullOrEmpty(''); // returns true
  /// StringHelper.isNullOrEmpty('hello'); // returns false
  /// ```
  static bool isNullOrEmpty(String? str) {
    return str == null || str.isEmpty;
  }

  /// Capitalizes the first letter of the given string.
  /// Capitalizes the first letter of a string.
  ///
  /// Takes a [str] and returns a new string with the first character
  /// converted to uppercase while keeping the rest of the string unchanged.
  ///
  /// Returns the original string if it is null or empty.
  ///
  /// Example:
  /// ```dart
  /// String result = StringHelper.capitalize('hello'); // Returns 'Hello'
  /// String result = StringHelper.capitalize(''); // Returns ''
  /// String result = StringHelper.capitalize(null); // Returns null
  /// ```
  ///
  /// Parameters:
  /// - [str]: The string to capitalize
  ///
  /// Returns: A new string with the first character capitalized, or the
  /// original string if null or empty
  static String capitalize(String str) {
    if (isNullOrEmpty(str)) return str;
    return str[0].toUpperCase() + str.substring(1);
  }

  /// Truncates the string to the specified length and adds ellipsis if needed.
  /// Truncates a string to a specified maximum length and adds ellipsis if needed.
  ///
  /// This method takes a string and truncates it to the specified [maxLength].
  /// If the original string is longer than [maxLength], it will be cut off
  /// and "..." will be appended to indicate truncation.
  ///
  /// Parameters:
  /// - [str]: The input string to be truncated
  /// - [maxLength]: The maximum allowed length for the string
  ///
  /// Returns:
  /// - The original string if its length is less than or equal to [maxLength]
  /// - A truncated string with "..." appended if the original exceeds [maxLength]
  ///
  /// Example:
  /// ```dart
  /// String result = StringHelper.truncateWithEllipsis("Hello World", 8);
  /// // Returns: "Hello Wo..."
  /// ```
  static String truncateWithEllipsis(String str, int maxLength) {
    if (str.length <= maxLength) return str;
    return '${str.substring(0, maxLength)}...';
  }

  /// Reverses the given string.
  /// Reverses the characters in a string.
  ///
  /// Takes a string [str] and returns a new string with all characters
  /// in reverse order.
  ///
  /// Example:
  /// ```dart
  /// String result = StringHelper.reverse("hello");
  /// print(result); // Output: "olleh"
  /// ```
  ///
  /// Parameters:
  /// - [str]: The input string to be reversed
  ///
  /// Returns:
  /// A new string with characters in reverse order
  static String reverse(String str) {
    return str.split('').reversed.join();
  }
}
