import 'package:flutter/foundation.dart' show immutable;
import 'package:clean_architecture_cubit/common/usecase/usecase.dart';
import 'package:clean_architecture_cubit/common/network/api_result.dart';
import 'package:clean_architecture_cubit/features/todo/data/models/todo.dart';
import 'package:clean_architecture_cubit/features/todo/domain/repositories/todo_repository.dart';

@immutable
class DeleteTodoUseCase implements UseCase<bool, DeleteTodoParams> {
  final TodoRepository todoRepository;

  const DeleteTodoUseCase(this.todoRepository);

  @override
  Future<ApiResult<bool>> call(DeleteTodoParams params) async {
    return await todoRepository.deleteTodo(params.todo);
  }
}

@immutable
class DeleteTodoParams {
  final ToDo todo;

  const DeleteTodoParams(this.todo);
}
