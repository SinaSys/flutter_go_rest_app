import 'package:clean_architecture_rxdart/common/usecase/usecase.dart';
import 'package:clean_architecture_rxdart/common/network/api_result.dart';
import 'package:clean_architecture_rxdart/features/todo/data/models/todo.dart';
import 'package:clean_architecture_rxdart/features/todo/domain/repositories/todo_repository.dart';

class UpdateTodoUseCase implements UseCase<bool, UpdateTodoParams> {
  final TodoRepository todoRepository;

  const UpdateTodoUseCase(this.todoRepository);

  @override
  Future<ApiResult<bool>> call(UpdateTodoParams params) async {
    return await todoRepository.updateTodo(params.todo);
  }
}

class UpdateTodoParams {
  final ToDo todo;

  const UpdateTodoParams(this.todo);
}
