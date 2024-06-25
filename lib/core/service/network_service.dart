import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:test_it_maha/core/service/connectivity_interceptor.dart';
import 'package:test_it_maha/core/service/refresh_token_interceptor.dart';

class NetworkService {
  late Dio _dio;

  NetworkService({String? baseUrl}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl ?? 'https://reqres.in',
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        connectTimeout: Duration(milliseconds: 90000),
        receiveTimeout: Duration(milliseconds: 50000),
        receiveDataWhenStatusError: true,
      ),
    );

    _dio.interceptors.addAll([
      LogInterceptor(responseBody: true, requestBody: true),
      ConnectivityInterceptor(),
      ChuckerDioInterceptor(),
      RefreshTokenInterceptor(),
    ]);
  }

  NetworkService token(String token) {
    _dio.options.headers.addAll({});
    return this;
  }

  NetworkService addOtherHeader({required Map<String, String> headers}) {
    _dio.options.headers.addAll(headers);
    return this;
  }

  NetworkService setFormUrlEncodedContentType() {
    _dio.options.headers.addAll({
      'Content-Type': 'application/json',
    });
    return this;
  }

  Dio get call => _dio;
}
