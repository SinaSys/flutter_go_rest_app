import 'package:clean_architecture_getx/features/todo/domain/repositories/todo_repository.dart';
import 'package:clean_architecture_getx/features/todo/data/models/todo.dart';
import 'package:clean_architecture_getx/common/usecase/usecase.dart';
import 'package:dartz/dartz.dart';

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
