import 'package:clean_architecture_bloc/common/network/api_result.dart';

import '../../../../common/usecase/usecase.dart';
import '../../data/models/todo.dart';
import '../repositories/todo_repository.dart';

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
