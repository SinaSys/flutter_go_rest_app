import 'package:clean_architecture_bloc/common/bloc/bloc_helper.dart';
import 'package:clean_architecture_bloc/common/bloc/generic_bloc_state.dart';
import 'package:clean_architecture_bloc/features/todo/data/models/todo.dart';
import 'package:clean_architecture_bloc/features/todo/domain/usecases/create_todo_usecase.dart';
import 'package:clean_architecture_bloc/features/todo/domain/usecases/delete_todo_usecase.dart';
import 'package:clean_architecture_bloc/features/todo/domain/usecases/get_todos_usecase.dart';
import 'package:clean_architecture_bloc/features/todo/domain/usecases/update_todo_usecase.dart';
import 'package:clean_architecture_bloc/features/todo/presentation/bloc/todo_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef Emit = Emitter<GenericBlocState<ToDo>>;

class TodoBloc extends Bloc<TodoEvent, GenericBlocState<ToDo>>
    with BlocHelper<ToDo> {
  TodoBloc({
    required this.createTodoUseCase,
    required this.updateTodoUseCase,
    required this.deleteTodoUseCase,
    required this.getTodoUseCase,
  }) : super(GenericBlocState.loading()) {
    on<TodoFetched>(getTodos);
    on<TodoCreated>(createTodo);
    on<TodoUpdated>(updateTodo);
    on<TodoDeleted>(deleteTodo);
  }

  final CreateTodoUseCase createTodoUseCase;
  final UpdateTodoUseCase updateTodoUseCase;
  final DeleteTodoUseCase deleteTodoUseCase;
  final GetTodoUseCase getTodoUseCase;

  String get getTodoCount => "${state.data?.length ?? 0}";

  Future<void> getTodos(TodoFetched event, Emit emit) async {
    await getItems(getTodoUseCase.call(GetTodoParams(userId: event.userId, status: event.status)), emit);
  }

  Future<void> createTodo(TodoCreated event, Emit emit) async {
    await createItem(createTodoUseCase.call(CreateTodoParams(event.todo)), emit);
  }

  Future<void> updateTodo(TodoUpdated event, Emit emit) async {
    await updateItem(updateTodoUseCase.call(UpdateTodoParams(event.todo)), emit);
  }

  Future<void> deleteTodo(TodoDeleted event, Emit emit) async {
    await deleteItem(deleteTodoUseCase.call(DeleteTodoParams(event.todo)), emit);
  }
}
