import 'package:dio/dio.dart';
import 'package:layered_architecture_bloc/core/api_config.dart';
import 'package:layered_architecture_bloc/common/network/dio_interceptor.dart';

//singleton class for DioClient
class DioClient {
  static final DioClient _instance = DioClient._internal();
  late final Dio? dio;

  factory DioClient() => _instance;

  DioClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrl,
        headers: ApiConfig.headers,
        connectTimeout: ApiConfig.connectionTimeout,
        receiveTimeout: ApiConfig.receiveTimeout,
        responseType: ResponseType.json,
      ),
    )..interceptors.add(DioInterceptor());
  }
}
