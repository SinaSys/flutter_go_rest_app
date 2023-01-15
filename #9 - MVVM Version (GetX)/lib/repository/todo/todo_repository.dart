import 'package:mvvm_getx/common/repository/repository_helper.dart';
import 'package:mvvm_getx/data/api/todo/todo_api.dart';
import 'package:mvvm_getx/data/model/todo/todo.dart';
import 'package:dartz/dartz.dart';

class TodoRepository with RepositoryHelper<ToDo> {
  final ToDoApi todoApi;

  const TodoRepository({required this.todoApi});

  Future<Either<String, List<ToDo>>> getTodos(int userId, {TodoStatus? status}) async {
    return checkItemsFailOrSuccess(todoApi.getTodos(userId, status: status));
  }

  Future<Either<String, bool>> createTodo(ToDo todo) async {
    return checkItemFailOrSuccess(todoApi.createTodo(todo));
  }

  Future<Either<String, bool>> updateTodo(ToDo todo) async {
    return checkItemFailOrSuccess(todoApi.updateTodo(todo));
  }

  Future<Either<String, bool>> deleteTodo(ToDo todo) async {
    return checkItemFailOrSuccess(todoApi.deleteTodo(todo));
  }
}
