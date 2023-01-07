import 'package:dartz/dartz.dart';

import '../../../../common/usecase/usecase.dart';
import '../../data/models/todo.dart';
import '../repositories/todo_repository.dart';

class CreateTodoUseCase implements UseCase<bool, CreateTodoParams> {
  final TodoRepository todoRepository;

  CreateTodoUseCase(this.todoRepository);

  @override
  Future<Either<String, bool>> call(CreateTodoParams params) async {
    return await todoRepository.createTodo(params.todo);
  }
}

class CreateTodoParams {
  final ToDo todo;

  CreateTodoParams(this.todo);
}
