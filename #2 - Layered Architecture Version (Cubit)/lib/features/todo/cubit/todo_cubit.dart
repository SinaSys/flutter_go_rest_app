import 'package:layered_architecture_cubit/features/todo/data/model/todo.dart';
import 'package:layered_architecture_cubit/features/todo/data/provider/remote/todo_api.dart';
import 'package:layered_architecture_cubit/features/user/cubit/user_cubit.dart';

import '../../../common/cubit/generic_cubit.dart';

class TodoCubit extends GenericCubit<ToDo> {

  final ToDoApi _toDoApi = ToDoApi();

  String get getTodoCount => "${state.data?.length ?? 0}";

  Future<void> getTodos(int userId, {TodoStatus? status}) async {
    operation = ApiOperation.select;
    getItems(_toDoApi.getTodos(userId, status: status));
  }

  Future<void> createTodo(ToDo todo) async {
    operation = ApiOperation.create;
    createItem(_toDoApi.createTodo(todo));
  }

  Future<void> deleteTodo(ToDo todo) async {
    operation = ApiOperation.delete;
    deleteItem(_toDoApi.deleteTodo(todo));
  }

  Future<void> updateTodo(ToDo todo) async {
    operation = ApiOperation.update;
    updateItem(_toDoApi.updateTodo(todo));
  }
}
