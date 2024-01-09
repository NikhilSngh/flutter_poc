import 'package:flutter_poc/data/network/api_client.dart';
import 'package:flutter_poc/data/network/api_service.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

void setUp(){

  serviceLocator.registerSingleton<ApiService>(ApiService());
  serviceLocator.registerSingleton<ApiClient>(ApiClient());

}
