import 'package:flutter/material.dart';
import 'package:online_groceries_store_app/app.dart';
import 'package:online_groceries_store_app/di/env_module.dart';
import 'package:online_groceries_store_app/di/injector.dart';

/// staging main function
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies(env: staging.name);

  runApp(const MyApp());
}
