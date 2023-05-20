import 'package:flutter/foundation.dart' show immutable;
import 'package:clean_architecture_rxdart/features/todo/domain/entities/todo_entity.dart';

@immutable
class TodoFetched {
  final int userId;
  final TodoStatus? status;

  const TodoFetched(this.userId, {this.status});
}
