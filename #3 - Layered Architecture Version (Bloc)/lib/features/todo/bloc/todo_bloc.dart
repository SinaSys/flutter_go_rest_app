import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:layered_architecture_bloc/features/todo/bloc/todo_event.dart';
import 'package:layered_architecture_bloc/features/todo/data/model/todo.dart';

import '../../../common/bloc/bloc_helper.dart';
import '../../../common/bloc/generic_bloc_state.dart';
import '../data/provider/remote/todo_api.dart';

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
    operation = ApiOperation.select;
    await getItems(_toDoApi.getTodos(event.userId, status: event.status), emit);
  }

  Future<void> createTodo(TodoCreated event, Emit emit) async {
    operation = ApiOperation.create;
    await createItem(_toDoApi.createTodo(event.todo), emit);
  }

  Future<void> updateTodo(TodoUpdated event, Emit emit) async {
    operation = ApiOperation.update;
    await updateItem(_toDoApi.updateTodo(event.todo), emit);
  }

  Future<void> deleteTodo(TodoDeleted event, Emit emit) async {
    operation = ApiOperation.delete;
    await deleteItem(_toDoApi.deleteTodo(event.todo), emit);
  }
}
