import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/riverpod/generic_provider.dart';
import '../../../../common/riverpod/generic_state.dart';
import '../../../../di.dart';
import '../../data/models/todo.dart';
import '../../domain/entities/todo_entity.dart';
import '../../domain/usecases/create_todo_usecase.dart';
import '../../domain/usecases/delete_todo_usecase.dart';
import '../../domain/usecases/get_todos_usecase.dart';
import '../../domain/usecases/update_todo_usecase.dart';

final todoProvider = StateNotifierProvider<TodoNotifier, GenericState<ToDo>>(
  (_) => getIt<TodoNotifier>(),
);

// final getTodosCountProvider = Provider<int>(
//   (ref) {
//     final state = ref.watch(todoProvider);
//     return state.data?.length ?? 0;
//   },
// );

class TodoNotifier extends GenericStateNotifier<ToDo> {
  final GetTodoUseCase getTodoUseCase;
  final CreateTodoUseCase createTodoUseCase;
  final UpdateTodoUseCase updateTodoUseCase;
  final DeleteTodoUseCase deleteTodoUseCase;

  TodoNotifier({
    required this.getTodoUseCase,
    required this.createTodoUseCase,
    required this.updateTodoUseCase,
    required this.deleteTodoUseCase,
  });

  Future<void> getTodos(int userId, {TodoStatus? status}) async {
    getItems(
        getTodoUseCase.call(GetTodoParams(userId: userId, status: status)));
  }

  Future<void> createTodo(ToDo todo) async {
    createItem(createTodoUseCase.call(CreateTodoParams(todo)));
  }

  Future<void> updateTodo(ToDo todo) async {
    //  operation = ApiOperation.update;
    updateItem(updateTodoUseCase.call(UpdateTodoParams(todo)));
  }

  Future<void> deleteTodo(ToDo todo) async {
    //operation = ApiOperation.delete;
    deleteItem(deleteTodoUseCase.call(DeleteTodoParams(todo)));
  }
}
