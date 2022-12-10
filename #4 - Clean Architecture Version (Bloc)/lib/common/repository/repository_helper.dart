import 'package:dio/dio.dart';

import '../network/api_result.dart';
import '../network/dio_exception.dart';

mixin RepositoryHelper<T> {
  Future<ApiResult<List<T>>> checkItemsFailOrSuccess(Future<List<T>> apiCallback) async {
    try {
      final List<T> items = await apiCallback;
      return ApiResult.success(items);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return ApiResult.failure(errorMessage);
    }
  }

  Future<ApiResult<bool>> checkItemFailOrSuccess(Future<bool> apiCallback) async {
    try {
      await apiCallback;
      return const ApiResult.success(true);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return ApiResult.failure(errorMessage);
    }
  }
}
