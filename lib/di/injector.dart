// Create a global instance (or use GetIt.instance)
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'injector.config.dart';

/// Dependency injection configuration using GetIt service locator.
///
/// This file sets up the dependency injection container for the application
/// using the injectable package with GetIt as the service locator.

/// Global instance of GetIt service locator.
///
/// This singleton instance is used throughout the application to retrieve
/// registered dependencies and services.

/// Configures and initializes all dependencies for the application.
///
/// This function should be called at application startup to register all
/// services, repositories, and other dependencies based on the specified
/// environment configuration.
///
/// Parameters:
/// * [env] - The environment name (e.g., 'dev', 'prod', 'staging') that determines
///   which dependencies to register based on environment-specific configurations.
///
/// Returns:
/// * A [Future<void>] that completes when all dependencies have been successfully
///   registered and configured.
///
/// Example:
/// ```dart
/// await configureDependencies(env: 'prod');
/// ```

final getIt = GetIt.instance;

// 2. Register them at app startup
@injectableInit
Future<void> configureDependencies({required String env}) async {
  await getIt.init(environment: env);
}
