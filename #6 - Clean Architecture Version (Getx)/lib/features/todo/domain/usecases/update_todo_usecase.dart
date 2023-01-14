import 'package:clean_architecture_getx/common/usecase/usecase.dart';
import 'package:clean_architecture_getx/features/todo/data/models/todo.dart';
import 'package:clean_architecture_getx/features/todo/domain/repositories/todo_repository.dart';
import 'package:dartz/dartz.dart';


class UpdateTodoUseCase implements UseCase<bool, UpdateTodoParams> {
  final TodoRepository todoRepository;

  UpdateTodoUseCase(this.todoRepository);

  @override
  Future<Either<String, bool>> call(UpdateTodoParams params) async {
    return await todoRepository.updateTodo(params.todo);
  }
}

class UpdateTodoParams {
  final ToDo todo;

  UpdateTodoParams(this.todo);
}
