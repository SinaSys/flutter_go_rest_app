import 'package:clean_architecture_bloc/common/network/api_config.dart';
import 'package:clean_architecture_bloc/common/network/api_helper.dart';
import 'package:clean_architecture_bloc/common/network/dio_client.dart';
import 'package:clean_architecture_bloc/di.dart';
import 'package:clean_architecture_bloc/features/todo/data/models/todo.dart';
import 'package:clean_architecture_bloc/features/todo/domain/entities/todo_entity.dart';

abstract class TodoRemoteDataSource {
  Future<List<ToDo>> getTodos(int userId, {TodoStatus? status});

  Future<bool> createTodo(ToDo todo);

  Future<bool> updateTodo(ToDo todo);

  Future<bool> deleteTodo(ToDo todo);
}

class TodoRemoteDataSourceImpl with ApiHelper implements TodoRemoteDataSource {
  final DioClient dioClient = getIt<DioClient>();

  @override
  Future<bool> createTodo(ToDo todo) async {
    return await makePostRequest(dioClient.dio.post(ApiConfig.todos, data: todo));
  }

  @override
  Future<bool> updateTodo(ToDo todo) async {
    return await makePutRequest(dioClient.dio.put("${ApiConfig.todos}/${todo.id}", data: todo));
  }

  @override
  Future<bool> deleteTodo(ToDo todo) async {
    return await makeDeleteRequest(dioClient.dio.delete("${ApiConfig.todos}/${todo.id}"));
  }

  @override
  Future<List<ToDo>> getTodos(int userId, {TodoStatus? status}) async {
    Map<String, String> queryParameters = <String, String>{
      'user_id': "$userId"
    };

    if (status != null && status != TodoStatus.all) {
      queryParameters.addAll({'status': status.name});
    }

    return await makeGetRequest(
      dioClient.dio.get(ApiConfig.todos, queryParameters: queryParameters),
      ToDo.fromJson,
    );
  }
}
