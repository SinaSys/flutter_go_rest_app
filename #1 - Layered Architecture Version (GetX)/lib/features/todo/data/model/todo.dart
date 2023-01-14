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
  final Status status;

  factory ToDo.fromJson(Map<String, dynamic> json) => _$ToDoFromJson(json);

  Map<String, dynamic> toJson() => _$ToDoToJson(this);

  ToDo copyWith({
    int? id,
    int? userId,
    String? title,
    DateTime? dueOn,
    Status? status,
  }) {
    return ToDo(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      dueOn: dueOn ?? this.dueOn,
      status: status ?? this.status,
    );
  }

  @override
  String toString() {
    return 'ToDo{id: $id, userId: $userId, title: $title, dueOn: $dueOn, status: $status\n}';
  }
}

@JsonEnum()
enum Status {
  completed(true),
  pending(false),
  all(false);

  final bool value;

  const Status(this.value);
}
