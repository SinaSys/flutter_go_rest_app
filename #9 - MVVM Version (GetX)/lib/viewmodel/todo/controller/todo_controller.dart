import 'package:dartz/dartz.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../common/controller/base_controller.dart';
import '../../../data/model/todo/todo.dart';
import '../../../repository/todo/todo_repository.dart';

class ToDoController extends GetxController with StateMixin<List<ToDo>>, BaseController {
  List<ToDo> todoList = <ToDo>[].obs;
  RxInt todosCount = 0.obs;

  final TodoRepository todoRepository;

  ToDoController({required this.todoRepository});

  void createTodo(ToDo todo) async {
    createItem(todoRepository.createTodo(todo));
  }

  void updateTodo(ToDo todo) async {
    updateItem(todoRepository.updateTodo(todo));
  }

  void deleteTodo(ToDo todo) async {
    deleteItem(todoRepository.deleteTodo(todo));
  }

  Future<void> getTodos(int userId, {TodoStatus? status}) async {
    change(null, status: RxStatus.loading());

    Either<String, List<ToDo>> failureOrSuccess = (await todoRepository.getTodos(userId, status: status));

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
