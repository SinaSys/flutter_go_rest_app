import '../../../../../common/network/api_base.dart';
import '../../../../../common/network/api_result.dart';
import '../../../../../core/api_config.dart';
import '../../model/todo.dart';

class ToDoApi extends ApiBase<ToDo> {
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
    Future<ApiResult<List<ToDo>>> result = getData(
      dioClient.dio!.get(ApiConfig.todos, queryParameters: queryParameters),
      ToDo.fromJson,
    );

    return result;
  }

  Future<ApiResult<bool>> createTodo(ToDo todo) async {
    return await requestMethodTemplate(
      dioClient.dio!.post(ApiConfig.todos, data: todo),
    );
  }

  Future<ApiResult<bool>> deleteTodo(ToDo todo) async {
    return await requestMethodTemplate(
      dioClient.dio!.delete("${ApiConfig.todos}/${todo.id}"),
    );
  }

  Future<ApiResult<bool>> updateTodo(ToDo todo) async {
    return await requestMethodTemplate(
      dioClient.dio!.put("${ApiConfig.todos}/${todo.id}", data: todo),
    );
  }
}
