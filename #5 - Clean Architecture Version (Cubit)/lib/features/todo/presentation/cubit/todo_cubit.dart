import 'package:clean_architecture_cubit/common/cubit/generic_cubit.dart';
import 'package:clean_architecture_cubit/features/todo/data/models/todo.dart';
import 'package:clean_architecture_cubit/features/todo/domain/entities/todo_entity.dart';
import 'package:clean_architecture_cubit/features/todo/domain/usecases/create_todo_usecase.dart';
import 'package:clean_architecture_cubit/features/todo/domain/usecases/delete_todo_usecase.dart';
import 'package:clean_architecture_cubit/features/todo/domain/usecases/get_todos_usecase.dart';
import 'package:clean_architecture_cubit/features/todo/domain/usecases/update_todo_usecase.dart';

class TodoCubit extends GenericCubit<ToDo> {
  final CreateTodoUseCase createTodoUseCase;
  final UpdateTodoUseCase updateTodoUseCase;
  final DeleteTodoUseCase deleteTodoUseCase;
  final GetTodoUseCase getTodoUseCase;

  TodoCubit({
    required this.createTodoUseCase,
    required this.updateTodoUseCase,
    required this.deleteTodoUseCase,
    required this.getTodoUseCase,
  });

  String get getTodoCount => "${state.data?.length ?? 0}";

  Future<void> getTodos(int userId, {TodoStatus? status}) async {
    getItems(getTodoUseCase.call(GetTodoParams(userId: userId, status: status)));
  }

  Future<void> createTodo(ToDo todo) async {
    createItem(createTodoUseCase.call(CreateTodoParams(todo)));
  }

  Future<void> updateTodo(ToDo todo) async {
    updateItem(updateTodoUseCase.call(UpdateTodoParams(todo)));
  }

  Future<void> deleteTodo(ToDo todo) async {
    deleteItem(deleteTodoUseCase.call(DeleteTodoParams(todo)));
  }
}
