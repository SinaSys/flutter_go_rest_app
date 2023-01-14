import 'package:layered_architecture_cubit/features/todo/data/provider/remote/todo_api.dart';
import 'package:layered_architecture_cubit/features/todo/data/model/todo.dart';
import 'package:layered_architecture_cubit/common/cubit/generic_cubit.dart';

class TodoCubit extends GenericCubit<ToDo> {
  final ToDoApi toDoApi = ToDoApi();

  String get getTodoCount => "${state.data?.length ?? 0}";

  Future<void> getTodos(int userId, {TodoStatus? status}) async {
    getItems(toDoApi.getTodos(userId, status: status));
  }

  Future<void> createTodo(ToDo todo) async {
    createItem(toDoApi.createTodo(todo));
  }

  Future<void> updateTodo(ToDo todo) async {
    updateItem(toDoApi.updateTodo(todo));
  }

  Future<void> deleteTodo(ToDo todo) async {
    deleteItem(toDoApi.deleteTodo(todo));
  }
}
