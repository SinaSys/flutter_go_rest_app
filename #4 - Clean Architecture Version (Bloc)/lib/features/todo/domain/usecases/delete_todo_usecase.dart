import 'package:clean_architecture_bloc/common/network/api_result.dart';

import '../../../../common/usecase/usecase.dart';
import '../../data/models/todo.dart';
import '../repositories/todo_repository.dart';

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
