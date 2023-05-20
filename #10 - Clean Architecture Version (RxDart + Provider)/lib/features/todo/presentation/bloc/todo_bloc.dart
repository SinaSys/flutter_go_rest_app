import 'package:rxdart/rxdart.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:clean_architecture_rxdart/common/network/api_result.dart';
import 'package:clean_architecture_rxdart/common/bloc/generic_bloc_state.dart';
import 'package:clean_architecture_rxdart/features/todo/data/models/todo.dart';
import 'package:clean_architecture_rxdart/features/todo/presentation/bloc/todo_event.dart';
import 'package:clean_architecture_rxdart/features/todo/domain/usecases/get_todos_usecase.dart';
import 'package:clean_architecture_rxdart/features/todo/domain/usecases/create_todo_usecase.dart';
import 'package:clean_architecture_rxdart/features/todo/domain/usecases/delete_todo_usecase.dart';
import 'package:clean_architecture_rxdart/features/todo/domain/usecases/update_todo_usecase.dart';

@immutable
class TodoBloc {
  factory TodoBloc({
    createTodoUseCase,
    updateTodoUseCase,
    deleteTodoUseCase,
    getTodoUseCase,
  }) {
    final BehaviorSubject<int> getTodoCount = BehaviorSubject<int>();

    final BehaviorSubject<ToDo> deleteTodo = BehaviorSubject<ToDo>();

    final BehaviorSubject<ToDo> updateTodo = BehaviorSubject<ToDo>();

    final BehaviorSubject<ToDo> createTodo = BehaviorSubject<ToDo>();

    final BehaviorSubject<TodoFetched> getTodos = BehaviorSubject<TodoFetched>();

    final Stream<GenericBlocState<ToDo>> todoList =
        getTodos.asyncExpand<ApiResult<List<ToDo>>>(
      (todo) {
        return Rx.fromCallable(
          () {
            return getTodoUseCase.call(
              GetTodoParams(userId: todo.userId, status: todo.status),
            );
          },
        );
      }, //Return Stream<GenericBlocState<ToDo>>
    ).asyncMap<GenericBlocState<ToDo>>(
      (result) {
        return result.when(
          success: (List<ToDo> todos) {
            if (todos.isEmpty) {
              return GenericBlocState.empty();
            } else {
              getTodoCount.add(todos.length);
              return GenericBlocState.success(todos);
            }
          },
          failure: (String failure) async {
            return GenericBlocState.failure(failure);
          },
        );
      },
    ).startWith(GenericBlocState.loading());

    final Stream<GenericBlocState<bool>> isTodoDeleted =
        deleteTodo.asyncExpand<ApiResult<bool>>(
      (todo) {
        return Rx.fromCallable(
          () => deleteTodoUseCase.call(DeleteTodoParams(todo)),
        );
      },
    ).asyncMap<GenericBlocState<bool>>(
      (result) {
        return result.when(
          success: (_) async {
            getTodos.sink.add(TodoFetched(deleteTodo.value.userId));
            return GenericBlocState.success(null);
          },
          failure: (String failure) async {
            return GenericBlocState.failure(failure);
          },
        );
      },
    );

    final Stream<GenericBlocState<bool>> isTodoUpdated =
        updateTodo.asyncExpand<ApiResult<bool>>((todo) {
      return Rx.fromCallable(
          () => updateTodoUseCase.call(UpdateTodoParams(todo)));
    }).asyncMap<GenericBlocState<bool>>((result) {
      return result.when(
        success: (_) async {
          getTodos.sink.add(TodoFetched(updateTodo.value.userId));
          return GenericBlocState.success(null);
        },
        failure: (String failure) async {
          return GenericBlocState.failure(failure);
        },
      );
    }).startWith(GenericBlocState.loading());

    final Stream<GenericBlocState<bool>> isTodoCreated =
        createTodo.asyncExpand<ApiResult<bool>>((todo) {
      return Rx.fromCallable(
          () => createTodoUseCase.call(CreateTodoParams(todo)));
    }).asyncMap<GenericBlocState<bool>>((result) {
      return result.when(
        success: (_) async {
          getTodos.sink.add(TodoFetched(createTodo.value.userId));
          return GenericBlocState.success(null);
        },
        failure: (String failure) async {
          return GenericBlocState.failure(failure);
        },
      );
    }).startWith(GenericBlocState.loading());

    return TodoBloc._(
      getTodoUseCase: getTodoUseCase,
      createTodoUseCase: createTodoUseCase,
      updateTodoUseCase: updateTodoUseCase,
      deleteTodoUseCase: deleteTodoUseCase,
      getTodos: getTodos,
      todoList: todoList,
      deleteTodo: deleteTodo,
      isTodoDeleted: isTodoDeleted,
      isTodoUpdated: isTodoUpdated,
      updateTodo: updateTodo,
      createTodo: createTodo,
      isTodoCreated: isTodoCreated,
      getTodoCount: getTodoCount,
    );
  }

  //Use cases
  final CreateTodoUseCase createTodoUseCase;
  final UpdateTodoUseCase updateTodoUseCase;
  final DeleteTodoUseCase deleteTodoUseCase;
  final GetTodoUseCase getTodoUseCase;

  // read-only properties
  final Stream<GenericBlocState<ToDo>> todoList;
  final Stream<GenericBlocState<bool>> isTodoDeleted;
  final Stream<GenericBlocState<bool>> isTodoUpdated;
  final Stream<GenericBlocState<bool>> isTodoCreated;
  final Stream<int> getTodoCount;

  // write-only properties
  final Sink<TodoFetched> getTodos;
  final Sink<ToDo> deleteTodo;
  final Sink<ToDo> updateTodo;
  final Sink<ToDo> createTodo;

  //Private constructor
  const TodoBloc._({
    required this.createTodoUseCase,
    required this.updateTodoUseCase,
    required this.deleteTodoUseCase,
    required this.getTodoUseCase,
    required this.getTodos,
    required this.todoList,
    required this.isTodoDeleted,
    required this.deleteTodo,
    required this.updateTodo,
    required this.isTodoUpdated,
    required this.createTodo,
    required this.isTodoCreated,
    required this.getTodoCount,
  });

  void dispose() {
    getTodos.close();
    deleteTodo.close();
    updateTodo.close();
    createTodo.close();
  }
}
