import 'package:clean_architecture_getx/features/todo/domain/repositories/todo_repository.dart';
import 'package:clean_architecture_getx/features/todo/data/models/todo.dart';
import 'package:clean_architecture_getx/common/usecase/usecase.dart';
import 'package:dartz/dartz.dart';

class DeleteTodoUseCase implements UseCase<bool, DeleteTodoParams> {
  final TodoRepository todoRepository;

  DeleteTodoUseCase(this.todoRepository);

  @override
  Future<Either<String, bool>> call(DeleteTodoParams params) async {
    return await todoRepository.deleteTodo(params.todo);
  }
}

class DeleteTodoParams {
  final ToDo todo;

  DeleteTodoParams(this.todo);
}
