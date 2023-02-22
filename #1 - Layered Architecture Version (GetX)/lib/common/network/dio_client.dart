import 'package:layered_architecture/common/network/dio_interceptor.dart';
import 'package:layered_architecture/core/api_config.dart';
import 'package:dio/dio.dart';

//singleton class for DioClient
class DioClient {
  static final DioClient _instance = DioClient._internal();
  late final Dio? dio;

  factory DioClient() => _instance;

  DioClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrl,
        headers: ApiConfig.header,
        connectTimeout: ApiConfig.connectionTimeout,
        receiveTimeout: ApiConfig.receiveTimeout,
        responseType: ResponseType.json,
      ),
    )..interceptors.add(DioInterceptor());
  }
}
