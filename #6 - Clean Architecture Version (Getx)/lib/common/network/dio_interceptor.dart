import 'package:dio/dio.dart';
import 'package:clean_architecture_getx/core/app_extension.dart';
import 'package:clean_architecture_getx/core/app_style.dart' show logger;

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
    logger.e(options.method);
    logger.e('Error: ${err.error}, Message: ${err.message}');
    return super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.i('Response => StatusCode: ${response.statusCode}');
    logger.i('Response => Body: ${response.data}');
    return super.onResponse(response, handler);
  }
}
