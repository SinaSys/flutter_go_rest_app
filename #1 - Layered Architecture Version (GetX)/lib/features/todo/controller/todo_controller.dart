import 'package:layered_architecture/common/controller/base_controller.dart';
import 'package:layered_architecture/features/todo/data/model/todo.dart';
import 'package:layered_architecture/features/todo/data/provider/remote/todo_api.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

class ToDoController extends GetxController with StateMixin<List<ToDo>>, BaseController {
  final ToDoApi todoApi = ToDoApi();
  List<ToDo> todoList = <ToDo>[].obs;
  RxInt todosCount = 0.obs;

  void createTodo(ToDo todo) async {
    createItem(todoApi.createTodo(todo));
  }

  void updateTodo(ToDo todo) async {
    updateItem(todoApi.updateTodo(todo));
  }

  void deleteTodo(ToDo todo) async {
    deleteItem(todoApi.deleteTodo(todo));
  }

  Future<void> getTodos(int userId, {Status? status}) async {
    change(null, status: RxStatus.loading());

    Either<String, List<ToDo>> failureOrSuccess =
        await todoApi.getTodos(userId, status: status);

    failureOrSuccess.fold(
      (String failure) {
        change(null, status: RxStatus.error(failure));
      },
      (List<ToDo> todos) {
        todosCount.value = todos.length;
        todoList = todos.obs;
        if (todoList.isEmpty) {
          change(null, status: RxStatus.empty());
        } else {
          change(todos, status: RxStatus.success());
        }
      },
    );
  }
}
