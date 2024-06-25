import 'dart:async';

import 'package:dio/dio.dart' as dio;
import 'package:test_it_maha/core/di/injection.dart';
import 'package:test_it_maha/presentation/config/navigation_routes/routes.dart';
import 'package:get/get.dart';

class RefreshTokenInterceptor extends dio.Interceptor {
  Future? _lock;

  @override
  Future<dynamic> onError(
    dio.DioError err,
    dio.ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      if (_lock == null) {
        final completer = Completer();
        _lock = completer.future;

        completer.complete();
        _lock = null;
        return handler.resolve(err.response!);
      } else {
        await _lock!.whenComplete(() {
          return handler.reject(err);
        });
      }
    } else {
      return handler.next(err);
    }
  }
}
