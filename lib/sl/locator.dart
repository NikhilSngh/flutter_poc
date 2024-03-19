import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_poc/constant/app_shared_pref.dart';
import 'package:flutter_poc/data/network/api_client.dart';
import 'package:flutter_poc/data/network/api_service.dart';
import 'package:flutter_poc/db/db_manager.dart';
import 'package:flutter_poc/db/hive_manager.dart';
import 'package:flutter_poc/utils/file_manager.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

void setUp(){
  serviceLocator.registerSingleton<ApiService>(ApiService());
  serviceLocator.registerSingleton<ApiClient>(ApiClient());
  serviceLocator.registerSingleton<DBManager>(DBManager());
  serviceLocator.registerSingleton<AppSharedPref>(AppSharedPref());
  serviceLocator.registerSingleton<FileManager>(FileManager());
  serviceLocator.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  serviceLocator.registerSingleton<HiveManager>(HiveManager());
}
