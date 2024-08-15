import 'package:clean_architecture_getx/common/network/api_base.dart';
import 'package:clean_architecture_getx/common/network/api_config.dart';
import 'package:clean_architecture_getx/common/network/dio_client.dart';
import 'package:clean_architecture_getx/features/todo/data/models/todo.dart';
import 'package:clean_architecture_getx/features/todo/domain/entities/todo_entity.dart';

abstract class TodoRemoteDataSource {
  Future<List<ToDo>> getTodos(int userId, {TodoStatus? status});

  Future<bool> createTodo(ToDo todo);

  Future<bool> updateTodo(ToDo todo);

  Future<bool> deleteTodo(ToDo todo);
}

class TodoRemoteDataSourceImpl with ApiBase implements TodoRemoteDataSource {
  final DioClient dioClient;

  const TodoRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<bool> createTodo(ToDo todo) async {
    return await makePostRequest(
      dioClient.post(ApiConfig.todos, data: todo),
    );
  }

  @override
  Future<bool> updateTodo(ToDo todo) async {
    return await makePutRequest(
      dioClient.put("${ApiConfig.todos}/${todo.id}", data: todo),
    );
  }

  @override
  Future<bool> deleteTodo(ToDo todo) async {
    return await makeDeleteRequest(
      dioClient.delete("${ApiConfig.todos}/${todo.id}"),
    );
  }

  @override
  Future<List<ToDo>> getTodos(int userId, {TodoStatus? status}) async {
    Map<String, String> queryParameters = <String, String>{'user_id': "$userId"};

    if (status != null && status != TodoStatus.all) {
      queryParameters.addAll({'status': status.name});
    }

    return await makeGetRequest(
      dioClient.get(ApiConfig.todos, queryParameters: queryParameters),
      ToDo.fromJson,
    );
  }
}
