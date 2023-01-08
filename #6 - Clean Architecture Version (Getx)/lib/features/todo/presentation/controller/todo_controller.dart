import 'package:dartz/dartz.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../../common/controller/base_controller.dart';
import '../../data/models/todo.dart';
import '../../domain/entities/todo_entity.dart';
import '../../domain/usecases/create_todo_usecase.dart';
import '../../domain/usecases/delete_todo_usecase.dart';
import '../../domain/usecases/get_todos_usecase.dart';
import '../../domain/usecases/update_todo_usecase.dart';

class ToDoController extends GetxController with StateMixin<List<ToDo>>, BaseController {
  List<ToDo> todoList = <ToDo>[].obs;
  RxInt todosCount = 0.obs;

  final CreateTodoUseCase createTodoUseCase;
  final UpdateTodoUseCase updateTodoUseCase;
  final DeleteTodoUseCase deleteTodoUseCase;
  final GetTodoUseCase getTodoUseCase;

  ToDoController({
    required this.createTodoUseCase,
    required this.updateTodoUseCase,
    required this.deleteTodoUseCase,
    required this.getTodoUseCase,
  });

  void createTodo(ToDo todo) async {
    createItem(createTodoUseCase.call(CreateTodoParams(todo)));
  }

  void updateTodo(ToDo todo) async {
    updateItem(updateTodoUseCase.call(UpdateTodoParams(todo)));
  }

  void deleteTodo(ToDo todo) async {
    deleteItem(deleteTodoUseCase.call(DeleteTodoParams(todo)));
  }

  Future<void> getTodos(int userId, {TodoStatus? status}) async {
    change(null, status: RxStatus.loading());
    Either<String, List<ToDo>> failureOrSuccess = (await getTodoUseCase
        .call(GetTodoParams(status: status, userId: userId)));
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
