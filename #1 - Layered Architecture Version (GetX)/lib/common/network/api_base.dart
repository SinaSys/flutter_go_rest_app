import 'package:layered_architecture/common/network/dio_exception.dart';
import 'package:layered_architecture/common/network/dio_client.dart';
import 'package:dio/dio.dart' show Response, DioException;
import 'package:dartz/dartz.dart';
import 'dart:convert';

abstract class ApiBase {
  //dioClient will be used in child classes
  final DioClient dioClient = DioClient();

  //Method template for checking whether api call is success or not
  Future<Either<String, bool>> _checkFailureOrSuccess(
      Future<Response<dynamic>> apiCallback) async {
    try {
      await apiCallback;
      return right(true);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return left(errorMessage);
    }
  }

  //Generic method template for create item on server
  Future<Either<String, bool>> makePostRequest(
      Future<Response<dynamic>> apiCallback) async {
    return _checkFailureOrSuccess(apiCallback);
  }

  //Generic method template for update item on server
  Future<Either<String, bool>> makePutRequest(
      Future<Response<dynamic>> apiCallback) async {
    return _checkFailureOrSuccess(apiCallback);
  }

  //Generic method template for delete item from server
  Future<Either<String, bool>> makeDeleteRequest(
      Future<Response<dynamic>> apiCallback) async {
    return _checkFailureOrSuccess(apiCallback);
  }

  //Generic Method template for getting data from server
  Future<Either<String, List<T>>> makeGetRequest<T>(
      Future<Response<dynamic>> apiCallback,
      T Function(Map<String, dynamic> json) getJsonCallback) async {
    try {
      final Response response = await apiCallback;

      final List<T> dataList = List<T>.from(
        json.decode(json.encode(response.data)).map(
              (item) => getJsonCallback(item),
            ),
      );
      return right(dataList);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return left(errorMessage);
    }
  }
}
