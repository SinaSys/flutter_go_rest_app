import 'package:layered_architecture_cubit/common/network/dio_exception.dart';
import 'package:layered_architecture_cubit/common/network/api_result.dart';
import 'package:layered_architecture_cubit/common/network/dio_client.dart';
import 'package:dio/dio.dart' show Response, DioException;
import 'dart:convert';

abstract class ApiBase {
  final DioClient dioClient = DioClient();

  Future<ApiResult<bool>> _requestMethodTemplate(
    Future<Response<dynamic>> apiCallback,
  ) async {
    try {
      await apiCallback;
      return const ApiResult.success(true);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return ApiResult.failure(errorMessage);
    }
  }

  //Generic method template for create item on server
  Future<ApiResult<bool>> makePostRequest(Future<Response<dynamic>> apiCallback) async {
    return _requestMethodTemplate(apiCallback);
  }

  //Generic method template for update item on server
  Future<ApiResult<bool>> makePutRequest(Future<Response<dynamic>> apiCallback) async {
    return _requestMethodTemplate(apiCallback);
  }

  //Generic method template for delete item from server
  Future<ApiResult<bool>> makeDeleteRequest(Future<Response<dynamic>> apiCallback) async {
    return _requestMethodTemplate(apiCallback);
  }

  //Generic method template for getting data from Api
  Future<ApiResult<List<T>>> makeGetRequest<T>(
    Future<Response<dynamic>> apiCallback,
    T Function(Map<String, dynamic> json) getJsonCallback,
  ) async {
    try {
      final Response response = await apiCallback;

      final List<T> dataList = List<T>.from(
        json.decode(json.encode(response.data)).map(
              (item) => getJsonCallback(item),
            ),
      );
      return ApiResult.success(dataList);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return ApiResult.failure(errorMessage);
    }
  }
}
