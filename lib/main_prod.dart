import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:online_groceries_store_app/app.dart';
import 'package:online_groceries_store_app/di/injector.dart';

/// prod main function
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies(env: prod.name);

  runApp(const MyApp());
}
