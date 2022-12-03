import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:layered_architecture_cubit/common/network/api_result.dart';
import 'dio_client.dart';
import 'dio_exception.dart';

abstract class ApiBase<T> {
  final DioClient dioClient = DioClient();
  late final T data;

  //Generic Method template for get data
  Future<ApiResult<List<T>>> getData(Future<Response<dynamic>> apiCallback,
      T Function(Map<String, dynamic> json) getJsonCallback) async {
    try {
      final Response response = await apiCallback;

      final List<T> dataList = List<T>.from(
        json.decode(json.encode(response.data)).map(
              (item) => getJsonCallback(item),
            ),
      );
      return ApiResult.success(dataList);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return ApiResult.failure(errorMessage);
    }
  }

  //Generic Method template for crete/update and delete operation on Api classes
  Future<ApiResult<bool>> requestMethodTemplate(
      Future<Response<dynamic>> apiCallback) async {
    try {
      await apiCallback;
      return const ApiResult.success(true);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return ApiResult.failure(errorMessage);
    }
  }
}
