// Create a global instance (or use GetIt.instance)
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'injector.config.dart';

final getIt = GetIt.instance;

// 2. Register them at app startup
@injectableInit
Future<void> configureDependencies({required String env}) async {
  await getIt.init(environment: env);
}
