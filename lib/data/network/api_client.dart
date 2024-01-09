import 'package:dio/dio.dart';
import 'package:flutter_poc/data/model/base_response.dart';
import 'package:flutter_poc/data/network/api_interface.dart';
import 'package:flutter_poc/data/network/api_service.dart';
import 'package:flutter_poc/sl/locator.dart';


class ApiClient implements ApiInterface {

  final ApiService _apiService = serviceLocator.get<ApiService>();

  @override
  void cancelRequests({CancelToken? cancelToken}) {
    _apiService.cancelRequests(cancelToken: cancelToken);
  }

  @override
  Future<T> getDataFromApi<T>({
    required String endpoint,
    JSON? queryParams,
    CancelToken? cancelToken,
    required T Function(JSON responseBody) converter,
  }) async {
    Object? body;
    try {
      // Entire map of response
      final data = await _apiService.getRequest<JSON>(
        endpoint,
        queryParams,
        cancelToken,
      );

      body = data.body;
    } on Exception catch (ex) {
      throw Exception(ex);
    }
    return mapObjectIntoModel(converter, body);
  }

  mapObjectIntoModel(Function(JSON responseBody) converter, Object body) {
    try {
      return converter(body as JSON);
    } on Exception catch (ex) {
      throw Exception(ex);
    }
  }

  @override
  Future<T> postDataFromApi<T>(
      {required String endpoint,
        required QueryParams? queryParam,
        CancelToken? cancelToken,
        Object? body,
        required T Function(JSON responseBody) converter}) async {
    Object? response;
    try {
      // Entire map of response
      final data = await _apiService.postRequest<BaseResponse?>(
          endpoint, queryParam, body, cancelToken);

      // Items of table as json
      response = data.body;
    } on Exception catch (ex) {
      throw Exception(ex);
    }
    return mapObjectIntoModel(converter, response!);
  }
}