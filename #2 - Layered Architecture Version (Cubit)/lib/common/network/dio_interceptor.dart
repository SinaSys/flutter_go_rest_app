import 'package:dio/dio.dart';
import 'package:layered_architecture_cubit/core/app_style.dart';
import 'package:layered_architecture_cubit/core/app_style.dart' show logger;

class DioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.i('====================START====================');
    logger.i('HTTP method => ${options.method} ');
    logger.i('Request => ${options.baseUrl}${options.path}${options.queryParameters.format}');
    logger.i('Header  => ${options.headers}');
    return super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final options = err.requestOptions;
    logger.e(options.method); // Debug log
    logger.e('Error: ${err.error}, Message: ${err.message}'); // Error log
    return super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.i('Response => StatusCode: ${response.statusCode}'); // Debug log
    logger.i('Response => Body: ${response.data}'); // Debug log
    return super.onResponse(response, handler);
  }
}
