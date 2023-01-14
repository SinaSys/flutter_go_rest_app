import 'package:clean_architecture_cubit/common/network/api_result.dart';
import 'package:clean_architecture_cubit/common/usecase/usecase.dart';
import 'package:clean_architecture_cubit/features/todo/data/models/todo.dart';
import 'package:clean_architecture_cubit/features/todo/domain/repositories/todo_repository.dart';

class DeleteTodoUseCase implements UseCase<bool, DeleteTodoParams> {
  final TodoRepository todoRepository;

  DeleteTodoUseCase(this.todoRepository);

  @override
  Future<ApiResult<bool>> call(DeleteTodoParams params) async {
    return await todoRepository.deleteTodo(params.todo);
  }
}

class DeleteTodoParams {
  final ToDo todo;

  DeleteTodoParams(this.todo);
}
