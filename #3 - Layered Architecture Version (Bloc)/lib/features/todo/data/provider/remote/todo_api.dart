import 'package:layered_architecture_bloc/features/todo/data/model/todo.dart';
import 'package:layered_architecture_bloc/common/network/api_result.dart';
import 'package:layered_architecture_bloc/common/network/api_base.dart';
import 'package:layered_architecture_bloc/core/api_config.dart';

class ToDoApi extends ApiBase {
  Future<ApiResult<bool>> createTodo(ToDo todo) async {
    return await createItem(dioClient.dio!.post(ApiConfig.todos, data: todo));
  }

  Future<ApiResult<bool>> updateTodo(ToDo todo) async {
    return await updateItem(dioClient.dio!.put("${ApiConfig.todos}/${todo.id}", data: todo));
  }

  Future<ApiResult<bool>> deleteTodo(ToDo todo) async {
    return await deleteItem(dioClient.dio!.delete("${ApiConfig.todos}/${todo.id}"));
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
    Future<ApiResult<List<ToDo>>> result = getItems(
      dioClient.dio!.get(ApiConfig.todos, queryParameters: queryParameters),
      ToDo.fromJson,
    );

    return result;
  }
}
