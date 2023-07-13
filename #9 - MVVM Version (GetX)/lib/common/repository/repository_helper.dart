import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' show DioException;
import 'package:mvvm_getx/common/network/dio_exception.dart';

mixin RepositoryHelper<T> {
  Future<Either<String, List<T>>> checkItemsFailOrSuccess(
    Future<List<T>> apiCallback,
  ) async {
    try {
      final List<T> items = await apiCallback;
      return Right(items);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return Left(errorMessage);
    }
  }

  Future<Either<String, bool>> checkItemFailOrSuccess(
    Future<bool> apiCallback,
  ) async {
    try {
      await apiCallback;
      return const Right(true);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return Left(errorMessage);
    }
  }
}
