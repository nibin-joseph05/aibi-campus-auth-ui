import 'package:dio/dio.dart';
import 'endpoints.dart';

class ApiClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: Endpoints.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        "Content-Type": "application/json",
      },
    ),
  );

  static Future<Response> post(
      String path, {
        Map<String, dynamic>? data,
        Map<String, dynamic>? headers,
      }) async {
    return await _dio.post(
      path,
      data: data,
      options: Options(headers: headers),
    );
  }
}
