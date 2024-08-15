import 'package:layered_architecture_cubit/features/todo/data/model/todo.dart';
import 'package:layered_architecture_cubit/common/network/api_base.dart';
import 'package:layered_architecture_cubit/common/network/api_result.dart';
import 'package:layered_architecture_cubit/core/api_config.dart';

class ToDoApi extends ApiBase {
  Future<ApiResult<bool>> createTodo(ToDo todo) async {
    return await makePostRequest(dioClient.dio!.post(ApiConfig.todos, data: todo));
  }

  Future<ApiResult<bool>> updateTodo(ToDo todo) async {
    return await makePutRequest(dioClient.dio!.put("${ApiConfig.todos}/${todo.id}", data: todo));
  }

  Future<ApiResult<bool>> deleteTodo(ToDo todo) async {
    return await makeDeleteRequest(dioClient.dio!.delete("${ApiConfig.todos}/${todo.id}"));
  }

  Future<ApiResult<List<ToDo>>> getTodos(
    int userId, {
    TodoStatus? status,
  }) async {
    Map<String, String> queryParameters = <String, String>{
      'user_id': "$userId"
    };

    if (status != null && status != TodoStatus.all) {
      queryParameters.addAll({'status': status.name});
    }
    Future<ApiResult<List<ToDo>>> result = makeGetRequest(
      dioClient.dio!.get(ApiConfig.todos, queryParameters: queryParameters),
      ToDo.fromJson,
    );

    return result;
  }
}
