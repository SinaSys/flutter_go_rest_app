import 'package:clean_architecture_getx/common/usecase/usecase.dart';
import 'package:clean_architecture_getx/features/todo/data/models/todo.dart';
import 'package:clean_architecture_getx/features/todo/domain/entities/todo_entity.dart';
import 'package:clean_architecture_getx/features/todo/domain/repositories/todo_repository.dart';
import 'package:dartz/dartz.dart';

class GetTodoUseCase implements UseCase<List<ToDo>, GetTodoParams> {
  final TodoRepository todoRepository;

  GetTodoUseCase(this.todoRepository);

  @override
  Future<Either<String, List<ToDo>>> call(GetTodoParams params) async {
    return await todoRepository.getTodos(params.userId, status: params.status);
  }
}

class GetTodoParams {
  int userId;
  TodoStatus? status;

  GetTodoParams({required this.userId, this.status});
}
