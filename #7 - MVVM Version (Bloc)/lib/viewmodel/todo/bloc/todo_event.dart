import 'package:mvvm_bloc/data/model/todo/todo.dart';

/// Events should be named in the past tense because events are things
/// that have already occurred from the bloc's perspective.

abstract class TodoEvent {}

class TodoFetched extends TodoEvent {
  final int userId;
  final TodoStatus? status;

  TodoFetched(this.userId, {this.status});
}

class TodoCreated extends TodoEvent {
  final ToDo todo;

  TodoCreated(this.todo);
}

class TodoUpdated extends TodoEvent {
  final ToDo todo;

  TodoUpdated(this.todo);
}

class TodoDeleted extends TodoEvent {
  final ToDo todo;

  TodoDeleted(this.todo);
}
