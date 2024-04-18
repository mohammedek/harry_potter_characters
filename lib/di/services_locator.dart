import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../services/character_services.dart';

GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton(() => CharacterService());
}
