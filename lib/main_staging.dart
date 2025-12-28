import 'package:flutter/material.dart';
import 'package:online_groceries_store_app/app.dart';
import 'package:online_groceries_store_app/di/env_module.dart';
import 'package:online_groceries_store_app/di/injector.dart';

/// Entry point for the staging environment of the application.
///
/// This function initializes the Flutter framework bindings, configures
/// dependency injection for the staging environment, and launches
/// the main application widget.
///
/// The function performs the following steps:
/// 1. Ensures Flutter widget bindings are initialized
/// 2. Configures dependencies using the staging environment settings
/// 3. Starts the application by running MyApp widget
///
/// This is typically used as the main entry point when building
/// the app for staging deployment.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies(env: staging.name);

  runApp(const MyApp());
}
