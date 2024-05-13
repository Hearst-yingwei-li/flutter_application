import "package:dio/dio.dart";

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  
  ApiClient._internal();
  factory ApiClient() {
    return _instance;
  }
  final Dio _dio = Dio();
  Dio get dio => _dio;
  
  Future<Response> get(String url, {Map<String, dynamic>? params}) async {
    return _dio.get(url, queryParameters: params);
  }

  Future<Response> post(String url, {Map<String, dynamic>? data}) async {
    return _dio.post(
      url,
      data: data,
      options: Options(headers: {
        'Accept': 'application/json',
      }),
    );
  }
}
