import 'package:clean_architecture_rxdart/common/usecase/usecase.dart';
import 'package:clean_architecture_rxdart/common/network/api_result.dart';
import 'package:clean_architecture_rxdart/features/todo/data/models/todo.dart';
import 'package:clean_architecture_rxdart/features/todo/domain/entities/todo_entity.dart';
import 'package:clean_architecture_rxdart/features/todo/domain/repositories/todo_repository.dart';

class GetTodoUseCase implements UseCase<List<ToDo>, GetTodoParams> {
  final TodoRepository todoRepository;

  const GetTodoUseCase(this.todoRepository);

  @override
  Future<ApiResult<List<ToDo>>> call(GetTodoParams params) async {
    return await todoRepository.getTodos(params.userId, status: params.status);
  }
}

class GetTodoParams {
  final int userId;
  final TodoStatus? status;

  const GetTodoParams({required this.userId, this.status});
}
