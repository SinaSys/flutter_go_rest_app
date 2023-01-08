import '../../../common/cubit/generic_cubit.dart';
import '../../../data/model/todo/todo.dart';
import '../../../repository/todo/todo_repository.dart';

class TodoCubit extends GenericCubit<ToDo> {
  final TodoRepository todoRepository;

  TodoCubit({required this.todoRepository});

  String get getTodoCount => "${state.data?.length ?? 0}";

  Future<void> getTodos(int userId, {TodoStatus? status}) async {
    operation = ApiOperation.select;
    getItems(todoRepository.getTodos(userId, status: status));
  }

  Future<void> createTodo(ToDo todo) async {
    operation = ApiOperation.create;
    createItem(todoRepository.createTodo(todo));
  }

  Future<void> updateTodo(ToDo todo) async {
    operation = ApiOperation.update;
    updateItem(todoRepository.updateTodo(todo));
  }

  Future<void> deleteTodo(ToDo todo) async {
    operation = ApiOperation.delete;
    deleteItem(todoRepository.deleteTodo(todo));
  }
}
