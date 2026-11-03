import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioClient {
  static Dio create() {
    final dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      headers: {'Accept': 'application/json'},
    ));

    dio.interceptors.add(LogInterceptor(
      requestBody: false,
      responseBody: false,
      logPrint: (o) => debugPrint(o.toString()),
    ));

    return dio;
  }
}