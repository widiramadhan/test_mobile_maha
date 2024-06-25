import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

class ConnectivityInterceptor extends Interceptor {
  final Connectivity _connectivity = Connectivity();

  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    var connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      handler.resolve(
        Response(
          requestOptions: options,
          statusCode: 503,
          statusMessage: 'no internet connection',
        ),
      );
    } else {
      handler.next(options);
    }
  }
}
