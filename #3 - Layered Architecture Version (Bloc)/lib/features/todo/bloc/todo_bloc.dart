import 'package:layered_architecture_bloc/features/todo/data/provider/remote/todo_api.dart';
import 'package:layered_architecture_bloc/common/bloc/generic_bloc_state.dart';
import 'package:layered_architecture_bloc/features/todo/bloc/todo_event.dart';
import 'package:layered_architecture_bloc/features/todo/data/model/todo.dart';
import 'package:layered_architecture_bloc/common/bloc/bloc_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


typedef Emit = Emitter<GenericBlocState<ToDo>>;

class TodoBloc extends Bloc<TodoEvent, GenericBlocState<ToDo>> with BlocHelper<ToDo> {
  TodoBloc() : super(GenericBlocState.loading()) {
    on<TodoFetched>(getTodos);
    on<TodoCreated>(createTodo);
    on<TodoUpdated>(updateTodo);
    on<TodoDeleted>(deleteTodo);
  }

  final ToDoApi _toDoApi = ToDoApi();

  String get getTodoCount => "${state.data?.length ?? 0}";

  Future<void> getTodos(TodoFetched event, Emit emit) async {
    await getItems(_toDoApi.getTodos(event.userId, status: event.status), emit);
  }

  Future<void> createTodo(TodoCreated event, Emit emit) async {
    await createItem(_toDoApi.createTodo(event.todo), emit);
  }

  Future<void> updateTodo(TodoUpdated event, Emit emit) async {
    await updateItem(_toDoApi.updateTodo(event.todo), emit);
  }

  Future<void> deleteTodo(TodoDeleted event, Emit emit) async {
    await deleteItem(_toDoApi.deleteTodo(event.todo), emit);
  }
}
