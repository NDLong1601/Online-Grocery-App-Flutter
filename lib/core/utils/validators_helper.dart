class ValidatorsHelper {
  ValidatorsHelper._();

  static final RegExp _emailRegex = RegExp(
    r'^[\w\.\-]+@([\w\-]+\.)+[\w\-]{2,}$',
  );

  /// true/false để show icon check realtime
  static bool isValidEmail(String value) {
    final v = value.trim();
    if (v.isEmpty) return false;
    return _emailRegex.hasMatch(v);
  }

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
