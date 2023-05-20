import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:clean_architecture_getx/common/usecase/usecase.dart';
import 'package:clean_architecture_getx/features/todo/data/models/todo.dart';
import 'package:clean_architecture_getx/features/todo/domain/entities/todo_entity.dart';
import 'package:clean_architecture_getx/features/todo/domain/repositories/todo_repository.dart';

@immutable
class GetTodoUseCase implements UseCase<List<ToDo>, GetTodoParams> {
  final TodoRepository todoRepository;

  const GetTodoUseCase(this.todoRepository);

  @override
  Future<Either<String, List<ToDo>>> call(GetTodoParams params) async {
    return await todoRepository.getTodos(params.userId, status: params.status);
  }
}

@immutable
class GetTodoParams {
  final int userId;
  final TodoStatus? status;

  const GetTodoParams({required this.userId, this.status});
}
