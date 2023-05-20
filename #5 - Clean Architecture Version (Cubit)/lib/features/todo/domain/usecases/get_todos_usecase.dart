import 'package:flutter/foundation.dart' show immutable;
import 'package:clean_architecture_cubit/common/usecase/usecase.dart';
import 'package:clean_architecture_cubit/common/network/api_result.dart';
import 'package:clean_architecture_cubit/features/todo/data/models/todo.dart';
import 'package:clean_architecture_cubit/features/todo/domain/entities/todo_entity.dart';
import 'package:clean_architecture_cubit/features/todo/domain/repositories/todo_repository.dart';

@immutable
class GetTodoUseCase implements UseCase<List<ToDo>, GetTodoParams> {
  final TodoRepository todoRepository;

  const GetTodoUseCase(this.todoRepository);

  @override
  Future<ApiResult<List<ToDo>>> call(GetTodoParams params) async {
    return await todoRepository.getTodos(params.userId, status: params.status);
  }
}

@immutable
class GetTodoParams {
  final int userId;
  final TodoStatus? status;

  const GetTodoParams({required this.userId, this.status});
}
