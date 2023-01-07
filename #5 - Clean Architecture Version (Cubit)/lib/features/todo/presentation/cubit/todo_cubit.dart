import '../../../../common/cubit/generic_cubit.dart';
import '../../data/models/todo.dart';
import '../../domain/entities/todo_entity.dart';
import '../../domain/usecases/create_todo_usecase.dart';
import '../../domain/usecases/delete_todo_usecase.dart';
import '../../domain/usecases/get_todos_usecase.dart';
import '../../domain/usecases/update_todo_usecase.dart';

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
    operation = ApiOperation.select;
    getItems(getTodoUseCase.call(GetTodoParams(userId: userId, status: status)));
  }

  Future<void> createTodo(ToDo todo) async {
    operation = ApiOperation.create;
    createItem(createTodoUseCase.call(CreateTodoParams(todo)));
  }

  Future<void> updateTodo(ToDo todo) async {
    operation = ApiOperation.update;
    updateItem(updateTodoUseCase.call(UpdateTodoParams(todo)));
  }

  Future<void> deleteTodo(ToDo todo) async {
    operation = ApiOperation.delete;
    deleteItem(deleteTodoUseCase.call(DeleteTodoParams(todo)));
  }
}
