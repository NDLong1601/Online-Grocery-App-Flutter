class ValidatorsHelper {
  ValidatorsHelper._();

  /// Regular expression pattern for validating email addresses.
  ///
  /// This regex validates email addresses with the following criteria:
  /// - Allows alphanumeric characters, dots, and hyphens in the local part
  /// - Requires an '@' symbol
  /// - Requires at least one domain segment with alphanumeric characters and hyphens
  /// - Requires a top-level domain with at least 2 characters
  ///
  /// Example matches:
  /// - user@example.com
  /// - test.email@sub.domain.org
  /// - user-name@example-site.co.uk
  static final RegExp _emailRegex = RegExp(
    r'^[\w\.\-]+@([\w\-]+\.)+[\w\-]{2,}$',
  );

  /// true/false để show icon check realtime
  /// Validates if the provided email address is in a valid format.
  ///
  /// This method checks if the email string is not empty after trimming
  /// whitespace and matches a valid email pattern using regex.
  ///
  /// Parameters:
  /// - [value]: The email string to validate
  ///
  /// Returns:
  /// - `true` if the email is valid and not empty
  /// - `false` if the email is empty or doesn't match the email pattern
  ///
  /// Example:
  /// ```dart
  /// bool isValid = ValidatorsHelper.isValidEmail('user@example.com'); // true
  /// bool isInvalid = ValidatorsHelper.isValidEmail('invalid-email'); // false
  /// bool isEmpty = ValidatorsHelper.isValidEmail('   '); // false
  /// ```
  static bool isValidEmail(String value) {
    final v = value.trim();
    if (v.isEmpty) return false;
    return _emailRegex.hasMatch(v);
  }

  /// Validates an email address for use in TextFormField validator.
  ///
  /// Trims whitespace from the input value and checks if it's empty or invalid.
  ///
  /// Parameters:
  /// - [value]: The email string to validate (nullable)
  ///
  /// Returns:
  /// - `String` with error message if validation fails
  /// - `null` if validation passes
  ///
  /// Error messages:
  /// - "Email is required" if the value is empty or null
  /// - "Invalid email" if the email format is invalid

  /// Validates if a password meets the minimum length requirement.
  ///
  /// Trims whitespace from the input and checks against the specified minimum length.
  ///
  /// Parameters:
  /// - [value]: The password string to validate
  /// - [minLength]: Minimum required length (defaults to 6)
  ///
  /// Returns:
  /// - `true` if password meets the length requirement
  /// - `false` if password is too short

  /// Validates a password for use in TextFormField validator.
  ///
  /// Trims whitespace from the input value and checks if it's empty or too short.
  ///
  /// Parameters:
  /// - [value]: The password string to validate (nullable)
  /// - [minLength]: Minimum required length (defaults to 6)
  ///
  /// Returns:
  /// - `String` with error message if validation fails
  /// - `null` if validation passes
  ///
  /// Error messages:
  /// - "Password is required" if the value is empty or null
  /// - "Password must be at least {minLength} characters" if too short
  /// Trả về error message hoặc null (dùng cho TextFormField validator)
  static String? email(String? value) {
    final v = (value ?? '').trim();
    if (v.isEmpty) return 'Email is required';
    if (!isValidEmail(v)) return 'Invalid email';
    return null;
  }

  static bool isValidPassword(String value, {int minLength = 6}) {
    final v = value.trim();
    return v.length >= minLength;
  }

  static String? password(String? value, {int minLength = 6}) {
    final v = (value ?? '').trim();
    if (v.isEmpty) return 'Password is required';
    if (!isValidPassword(v, minLength: minLength)) {
      return 'Password must be at least $minLength characters';
    }
    return null;
  }
}
