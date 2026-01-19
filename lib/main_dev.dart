import 'package:chottu_link/chottu_link.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:online_groceries_store_app/app.dart';
import 'package:online_groceries_store_app/di/injector.dart';

/// Entry point for the development environment of the application.
///
/// This function serves as the main entry point when running the app in
/// development mode. It performs the following initialization steps:
///
/// 1. Ensures Flutter widget binding is initialized before running any async operations
/// 2. Configures dependency injection with development environment settings
/// 3. Launches the main application widget
///
/// The function is marked as async to handle the asynchronous dependency
/// configuration process before starting the app.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies(env: dev.name);

  await ChottuLink.init(apiKey: "c_app_HVA1aQuhwhsY58hbCohVk8JMToIbC6V1");

  runApp(const MyApp());
}
