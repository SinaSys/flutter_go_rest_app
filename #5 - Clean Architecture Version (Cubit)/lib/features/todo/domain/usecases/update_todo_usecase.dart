import 'package:clean_architecture_cubit/common/network/api_result.dart';
import 'package:clean_architecture_cubit/common/usecase/usecase.dart';
import 'package:clean_architecture_cubit/features/todo/data/models/todo.dart';
import 'package:clean_architecture_cubit/features/todo/domain/repositories/todo_repository.dart';

class UpdateTodoUseCase implements UseCase<bool, UpdateTodoParams> {
  final TodoRepository todoRepository;

  UpdateTodoUseCase(this.todoRepository);

  @override
  Future<ApiResult<bool>> call(UpdateTodoParams params) async {
    return await todoRepository.updateTodo(params.todo);
  }
}

class UpdateTodoParams {
  final ToDo todo;

  UpdateTodoParams(this.todo);
}
