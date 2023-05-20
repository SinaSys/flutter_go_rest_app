import 'package:flutter/foundation.dart' show immutable;
import 'package:clean_architecture_bloc/common/usecase/usecase.dart';
import 'package:clean_architecture_bloc/common/network/api_result.dart';
import 'package:clean_architecture_bloc/features/todo/data/models/todo.dart';
import 'package:clean_architecture_bloc/features/todo/domain/repositories/todo_repository.dart';

@immutable
class CreateTodoUseCase implements UseCase<bool, CreateTodoParams> {
  final TodoRepository todoRepository;

  const CreateTodoUseCase(this.todoRepository);

  @override
  Future<ApiResult<bool>> call(CreateTodoParams params) async {
    return await todoRepository.createTodo(params.todo);
  }
}

@immutable
class CreateTodoParams {
  final ToDo todo;

  const CreateTodoParams(this.todo);
}
