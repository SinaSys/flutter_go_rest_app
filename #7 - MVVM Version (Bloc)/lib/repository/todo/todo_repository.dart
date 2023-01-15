import 'package:mvvm_bloc/common/repository/repository_helper.dart';
import 'package:mvvm_bloc/common/network/api_result.dart';
import 'package:mvvm_bloc/data/api/todo/todo_api.dart';
import 'package:mvvm_bloc/data/model/todo/todo.dart';

class TodoRepository with RepositoryHelper<ToDo> {
  final ToDoApi todoApi;

  const TodoRepository({required this.todoApi});

  Future<ApiResult<List<ToDo>>> getTodos(int userId, {TodoStatus? status}) async {
    return checkItemsFailOrSuccess(todoApi.getTodos(userId, status: status));
  }

  Future<ApiResult<bool>> createTodo(ToDo todo) async {
    return checkItemFailOrSuccess(todoApi.createTodo(todo));
  }

  Future<ApiResult<bool>> updateTodo(ToDo todo) async {
    return checkItemFailOrSuccess(todoApi.updateTodo(todo));
  }

  Future<ApiResult<bool>> deleteTodo(ToDo todo) async {
    return checkItemFailOrSuccess(todoApi.deleteTodo(todo));
  }
}
