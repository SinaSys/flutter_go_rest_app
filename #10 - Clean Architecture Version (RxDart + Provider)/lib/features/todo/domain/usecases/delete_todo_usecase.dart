import 'package:clean_architecture_rxdart/common/usecase/usecase.dart';
import 'package:clean_architecture_rxdart/common/network/api_result.dart';
import 'package:clean_architecture_rxdart/features/todo/data/models/todo.dart';
import 'package:clean_architecture_rxdart/features/todo/domain/repositories/todo_repository.dart';

class DeleteTodoUseCase implements UseCase<bool, DeleteTodoParams> {
  final TodoRepository todoRepository;

  const DeleteTodoUseCase(this.todoRepository);

  @override
  Future<ApiResult<bool>> call(DeleteTodoParams params) async {
    return await todoRepository.deleteTodo(params.todo);
  }
}

class DeleteTodoParams {
  final ToDo todo;

  const DeleteTodoParams(this.todo);
}
