import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../user/controller/user_controller.dart';
import '../data/model/todo.dart';
import '../data/provider/remote/todo_api.dart';

class ToDoController extends GetxController with StateMixin<List<ToDo>> {
  final ToDoApi _todoApi = ToDoApi();
  List<ToDo> todoList = <ToDo>[].obs;
  RxInt todosCount = 0.obs;
  Rx<String> errorMessage = "".obs;
  Rx<StatusX> statusX = StatusX.loading.obs;

  Future<bool> getTodos(int userId, {Status? status}) async {
    change(null, status: RxStatus.loading());
    Either<String, List<ToDo>> failureOrSuccess =
        await _todoApi.getTodos(userId, status: status);
    failureOrSuccess.fold(
      (String failure) {
        change(null, status: RxStatus.error(failure));
        return false;
      },
      (List<ToDo> todos) {
        todosCount.value = todos.length;
        todoList = todos.obs;
        if (todoList.isEmpty) {
          change(null, status: RxStatus.empty());
        } else {
          change(todos, status: RxStatus.success());
        }

        return true;
      },
    );
    return false;
  }

  //Method template for crete/update and delete operation
  void todoOperationTemplate(Future<Either<String, bool>> apiCallback) async {
    statusX.value = StatusX.loading;
    Either<String, bool> failureOrSuccess = await apiCallback;

    failureOrSuccess.fold(
          (String failure) {
            statusX.value = StatusX.error;
        errorMessage = failure.obs;
      },
          (bool success) {
            statusX.value = StatusX.success;
      },
    );
  }

  void createTodo(ToDo todo) async {
    todoOperationTemplate(_todoApi.createTodo(todo));
  }

  void deleteTodo(ToDo todo) async {
    todoOperationTemplate(_todoApi.deleteTodo(todo));

  }

  void updateTodo(ToDo todo) async {
    todoOperationTemplate(_todoApi.updateTodo(todo));
  }
}
