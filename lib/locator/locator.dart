import 'package:southshore3pl/Api/core/api_links.dart';
import 'package:southshore3pl/global/preferences.dart';
import 'package:get_it/get_it.dart';

import '../Api/core/api_exporter.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => Preferences());
  locator.registerLazySingleton(() => ApiLinks());
  locator.registerLazySingleton(() => ApiExporter());
}
