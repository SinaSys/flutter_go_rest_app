import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:clean_architecture_getx/common/usecase/usecase.dart';
import 'package:clean_architecture_getx/features/todo/data/models/todo.dart';
import 'package:clean_architecture_getx/features/todo/domain/repositories/todo_repository.dart';

@immutable
class CreateTodoUseCase implements UseCase<bool, CreateTodoParams> {
  final TodoRepository todoRepository;

  const CreateTodoUseCase(this.todoRepository);

  @override
  Future<Either<String, bool>> call(CreateTodoParams params) async {
    return await todoRepository.createTodo(params.todo);
  }
}

@immutable
class CreateTodoParams {
  final ToDo todo;

  const CreateTodoParams(this.todo);
}
