import '../../../common/cubit/generic_cubit.dart';
import '../../user/cubit/user_cubit.dart';
import '../data/model/todo.dart';
import '../data/provider/remote/todo_api.dart';

class TodoCubit extends GenericCubit<ToDo> {
  final ToDoApi toDoApi = ToDoApi();

  String get getTodoCount => "${state.data?.length ?? 0}";

  Future<void> getTodos(int userId, {TodoStatus? status}) async {
    operation = ApiOperation.select;
    getItems(toDoApi.getTodos(userId, status: status));
  }

  Future<void> createTodo(ToDo todo) async {
    operation = ApiOperation.create;
    createItem(toDoApi.createTodo(todo));
  }

  Future<void> updateTodo(ToDo todo) async {
    operation = ApiOperation.update;
    updateItem(toDoApi.updateTodo(todo));
  }

  Future<void> deleteTodo(ToDo todo) async {
    operation = ApiOperation.delete;
    deleteItem(toDoApi.deleteTodo(todo));
  }
}
