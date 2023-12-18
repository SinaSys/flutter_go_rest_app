import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:clean_architecture_getx/features/todo/domain/entities/todo_entity.dart';

part 'todo.g.dart';

@immutable
@JsonSerializable()
class ToDo extends TodoEntity {
  const ToDo({
    super.id,
    @JsonKey(name: "user_id") required super.userId,
    required super.title,
    @JsonKey(name: "due_on") required super.dueOn,
    @JsonKey(name: "status") required super.status,
  });

  factory ToDo.fromJson(Map<String, dynamic> json) => _$ToDoFromJson(json);

  Map<String, dynamic> toJson() => _$ToDoToJson(this);

  ///For unit testing
  @override
  bool operator ==(Object other) => identical(this, other) || other is ToDo && runtimeType == other.runtimeType;

  ///For unit testing
  @override
  int get hashCode => 0;

  ///For unit testing
  ToDo copyWith({
    int? id,
    int? userId,
    String? title,
    DateTime? dueOn,
    TodoStatus? status,
  }) {
    return ToDo(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      dueOn: dueOn ?? this.dueOn,
      status: status ?? this.status,
    );
  }
}
