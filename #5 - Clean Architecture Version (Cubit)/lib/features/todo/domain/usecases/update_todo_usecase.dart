import 'package:flutter/foundation.dart' show immutable;
import 'package:clean_architecture_cubit/common/usecase/usecase.dart';
import 'package:clean_architecture_cubit/common/network/api_result.dart';
import 'package:clean_architecture_cubit/features/todo/data/models/todo.dart';
import 'package:clean_architecture_cubit/features/todo/domain/repositories/todo_repository.dart';

@immutable
class UpdateTodoUseCase implements UseCase<bool, UpdateTodoParams> {
  final TodoRepository todoRepository;

  const UpdateTodoUseCase(this.todoRepository);

  @override
  Future<ApiResult<bool>> call(UpdateTodoParams params) async {
    return await todoRepository.updateTodo(params.todo);
  }
}

@immutable
class UpdateTodoParams {
  final ToDo todo;

  const UpdateTodoParams(this.todo);
}
