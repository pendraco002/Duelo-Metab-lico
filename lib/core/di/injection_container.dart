import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'injection_container.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async => getIt.init();

@module
abstract class RegisterModule {
  @preResolve
  @singleton
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
  
  @singleton
  Dio dio() {
    final dio = Dio();
    dio.options = BaseOptions(
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
    );
    return dio;
  }
  
  @preResolve
  @singleton
  Future<Box> get settingsBox async {
    await Hive.initFlutter();
    return await Hive.openBox('settings');
  }
  
  @preResolve
  @singleton
  Future<Box> get userBox async {
    await Hive.initFlutter();
    return await Hive.openBox('user_data');
  }
  
  @preResolve
  @singleton
  Future<Box> get gameBox async {
    await Hive.initFlutter();
    return await Hive.openBox('game_data');
  }
}