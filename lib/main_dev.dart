import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:online_groceries_store_app/app.dart';
import 'package:online_groceries_store_app/di/injector.dart';

/// develop main function
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies(env: dev.name);

  runApp(const MyApp());
}
