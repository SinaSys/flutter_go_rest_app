import 'package:layered_architecture/features/todo/data/model/todo.dart';
import 'package:layered_architecture/common/network/api_base.dart';
import 'package:layered_architecture/core/api_config.dart';
import 'package:dartz/dartz.dart';

class ToDoApi extends ApiBase {
  Future<Either<String, bool>> createTodo(ToDo todo) async {
    return await makePostRequest(dioClient.dio!.post(ApiConfig.todos, data: todo),
    );
  }

  Future<Either<String, bool>> updateTodo(ToDo todo) async {
    return await makePutRequest(dioClient.dio!.put("${ApiConfig.todos}/${todo.id}", data: todo),
    );
  }

  Future<Either<String, bool>> deleteTodo(ToDo todo) async {
    return await makeDeleteRequest(dioClient.dio!.delete("${ApiConfig.todos}/${todo.id}"),
    );
  }

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
    Future<Either<String, List<ToDo>>> result = makeGetRequest(
      dioClient.dio!.get(ApiConfig.todos, queryParameters: queryParameters),
      ToDo.fromJson,
    );

    return result;
  }
}
