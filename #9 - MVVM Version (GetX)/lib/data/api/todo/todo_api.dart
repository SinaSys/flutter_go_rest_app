import 'package:mvvm_getx/common/network/api_helper.dart';
import 'package:mvvm_getx/common/network/dio_client.dart';
import 'package:mvvm_getx/data/model/todo/todo.dart';
import 'package:mvvm_getx/core/api_config.dart';

class ToDoApi with ApiHelper<ToDo> {
  final DioClient dioClient;

  ToDoApi({required this.dioClient});

  Future<bool> createTodo(ToDo todo) async {
    return await makePostRequest(dioClient.dio.post(ApiConfig.todos, data: todo));
  }

  Future<bool> updateTodo(ToDo todo) async {
    return await makePutRequest(dioClient.dio.put("${ApiConfig.todos}/${todo.id}", data: todo));
  }

  Future<bool> deleteTodo(ToDo todo) async {
    return await makeDeleteRequest(dioClient.dio.delete("${ApiConfig.todos}/${todo.id}"));
  }

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
