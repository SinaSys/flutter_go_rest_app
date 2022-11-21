import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'dio_client.dart';
import 'dio_exception.dart';

abstract class ApiBase {
  final DioClient dioClient = DioClient();

  Future<Either<String, bool>> requestMethodTemplate(
      Future<Response<dynamic>> apiCallback) async {
    try {
      await apiCallback;
      return right(true);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return left(errorMessage);
    }
  }
}
