class BaseResponse<T>{
  final String? message;
  final int code;
  final T body;

  const BaseResponse({required this.body, this.message, required this.code});

  factory BaseResponse.fromJson(JSON json, ){
    return BaseResponse(
      body: json?['data'] as T,
      message: json?['message'] as String?,
      code: json?['code'] as int,
    );
  }
}

typedef JSON = Map<String, dynamic>;
typedef QueryParams = Map<String, String>;