import 'package:flutter/foundation.dart' show immutable;

@immutable
class TodoEntity {
  const TodoEntity({
    this.id,
    required this.userId,
    required this.title,
    required this.dueOn,
    required this.status,
  });

  final int? id;
  final int userId;
  final String title;
  final DateTime dueOn;
  final TodoStatus status;
}

enum TodoStatus {
  completed(true),
  pending(false),
  all(false);

  final bool value;

  const TodoStatus(this.value);
}
