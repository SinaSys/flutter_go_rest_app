import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/foundation.dart' show immutable;

part 'todo.g.dart';

@immutable
@JsonSerializable()
class ToDo {
  const ToDo({
    this.id,
    required this.userId,
    required this.title,
    required this.dueOn,
    required this.status,
  });

  final int? id;
  @JsonKey(name: "user_id")
  final int userId;
  final String title;
  @JsonKey(name: "due_on")
  final DateTime dueOn;
  @JsonKey(name: "status")
  final TodoStatus status;

  factory ToDo.fromJson(Map<String, dynamic> json) => _$ToDoFromJson(json);

  Map<String, dynamic> toJson() => _$ToDoToJson(this);
}

@JsonEnum()
enum TodoStatus {
  completed(true),
  pending(false),
  all(false);

  final bool value;

  const TodoStatus(this.value);
}
