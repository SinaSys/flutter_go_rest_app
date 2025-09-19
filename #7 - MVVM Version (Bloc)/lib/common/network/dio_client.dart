import 'package:mvvm_bloc/core/api_config.dart';
import 'package:dio/dio.dart' show Dio, ResponseType;
import 'package:mvvm_bloc/common/network/dio_interceptor.dart';

class DioClient {
  final Dio dio;

  DioClient(this.dio) {
    dio
      ..options.baseUrl = ApiConfig.baseUrl
      ..options.headers = ApiConfig.headers
      ..options.connectTimeout = ApiConfig.connectionTimeout
      ..options.receiveTimeout = ApiConfig.receiveTimeout
      ..options.responseType = ResponseType.json
      ..interceptors.add(DioInterceptor());
  }
}
