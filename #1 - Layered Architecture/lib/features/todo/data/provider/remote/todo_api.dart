import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../common/network/dio_client.dart';
import '../../../../../common/network/dio_exception.dart';
import '../../../../../core/api_config.dart';
import '../../model/todo.dart';

class ToDoApi {
  final DioClient dioClient = DioClient();

  Future<Either<String, List<ToDo>>> getTodos(
    int userId, {
    Status? status,
  }) async {
    Map<String, String> queryParameters = <String, String>{
      'user_id': "$userId"
    };

    if (status != null && status != Status.all) {
      queryParameters.addAll({'status': status.name});
    }

    try {
      final Response response = await dioClient.dio!
          .get(ApiConfig.todos, queryParameters: queryParameters);

      final List<ToDo> todos = toDoFromJson(json.encode(response.data));
      return right(todos);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return left(errorMessage);
    }
  }

  Future<Either<String, bool>> createTodo(ToDo todo) async {
    try {
      await dioClient.dio!.post(ApiConfig.todos, data: todo.toJson());

      return right(true);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return left(errorMessage);
    }
  }

  Future<Either<String, bool>> deleteTodo(ToDo todo) async {
    try {
      await dioClient.dio!.delete("${ApiConfig.todos}/${todo.id}");

      return right(true);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return left(errorMessage);
    }
  }

  Future<Either<String, bool>> updateTodo(ToDo todo) async {
    try {
      await dioClient.dio!.put(
        "${ApiConfig.todos}/${todo.id}",
        data: todo.toJson(),
      );
      return right(true);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return left(errorMessage);
    }
  }
}
