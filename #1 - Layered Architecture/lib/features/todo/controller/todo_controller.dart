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

  Future<bool> createTodo(ToDo todo) async {
    statusX.value = StatusX.loading;
    Either<String, bool> failureOrSuccess = await _todoApi.createTodo(todo);
    failureOrSuccess.fold(
      (String failure) {
        errorMessage = failure.obs;
        statusX.value = StatusX.error;
        return false;
      },
      (bool success) {
        statusX.value = StatusX.success;
        return true;
      },
    );
    return false;
  }

  Future<bool> deleteTodo(ToDo todoObject) async {
    statusX.value = StatusX.loading;
    Either<String, bool> failureOrSuccess =
        await _todoApi.deleteTodo(todoObject);
    failureOrSuccess.fold(
      (String failure) {
        statusX.value = StatusX.error;
        errorMessage = failure.obs;
        return false;
      },
      (bool success) {
        statusX.value = StatusX.success;
        return true;
      },
    );
    return false;
  }

  Future<bool> updateTodo(ToDo todoObject) async {
    statusX.value = StatusX.loading;
    Either<String, bool> failureOrSuccess =
        await _todoApi.updateTodo(todoObject);
    failureOrSuccess.fold(
      (String failure) {
        statusX.value = StatusX.error;
        errorMessage = failure.obs;

        return false;
      },
      (bool success) {
        statusX.value = StatusX.success;
        return true;
      },
    );
    return false;
  }
}
