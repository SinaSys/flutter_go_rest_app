// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ToDo _$ToDoFromJson(Map<String, dynamic> json) => ToDo(
      id: json['id'] as int?,
      userId: json['user_id'] as int,
      title: json['title'] as String,
      dueOn: DateTime.parse(json['due_on'] as String),
      status: $enumDecode(_$StatusEnumMap, json['status']),
    );

Map<String, dynamic> _$ToDoToJson(ToDo instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'title': instance.title,
      'due_on': instance.dueOn.toIso8601String(),
      'status': _$StatusEnumMap[instance.status]!,
    };

const _$StatusEnumMap = {
  Status.completed: 'completed',
  Status.pending: 'pending',
  Status.all: 'all',
};
