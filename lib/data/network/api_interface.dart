import 'package:dio/dio.dart';

import '../model/base_response.dart';

abstract class ApiInterface {
  const ApiInterface();

  void cancelRequests({CancelToken? cancelToken});

  Future<T> getDataFromApi<T>({
    required String endpoint,
    JSON? queryParams,
    CancelToken? cancelToken,
    required T Function(JSON responseBody) converter,
  });

  Future<T> postDataFromApi<T>(
      {required String endpoint,
        required QueryParams? queryParam,
        CancelToken? cancelToken,
        Object? body,
        required T Function(JSON responseBody) converter});
}