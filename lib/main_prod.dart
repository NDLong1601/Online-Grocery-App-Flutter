import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:online_groceries_store_app/app.dart';
import 'package:online_groceries_store_app/di/injector.dart';

/// Entry point for the production environment of the application.
///
/// This function initializes the Flutter framework bindings, configures
/// dependency injection for the production environment, and launches
/// the main application widget.
///
/// The function performs the following steps:
/// 1. Ensures Flutter widget bindings are initialized
/// 2. Configures dependencies using the production environment settings
/// 3. Starts the application by running MyApp widget
///
/// This is typically used as the main entry point when building
/// the app for production deployment.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies(env: prod.name);

  runApp(const MyApp());
}
