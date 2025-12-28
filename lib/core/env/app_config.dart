import 'package:online_groceries_store_app/core/env/flavor.dart';

/// Configuration class that holds application-specific settings and environment variables.
///
/// This class encapsulates the application's runtime configuration including
/// the current flavor/environment and the base URL for API endpoints.
///
/// Example usage:
/// ```dart
/// final config = AppConfig(
///   flavor: Flavor.development,
///   baseUrl: 'https://api.example.com',
/// );
/// ```
class AppConfig {
  final Flavor flavor;
  final String baseUrl;

  AppConfig({required this.flavor, required this.baseUrl});
}
