import 'package:clean_architecture_bloc/common/network/api_result.dart';
import 'package:clean_architecture_bloc/features/todo/data/models/todo.dart';
import 'package:clean_architecture_bloc/features/todo/domain/repositories/todo_repository.dart';

import '../../../../common/usecase/usecase.dart';

class CreateTodoUseCase implements UseCase<bool, CreateTodoParams> {
  final TodoRepository todoRepository;

  CreateTodoUseCase(this.todoRepository);

  @override
  Future<ApiResult<bool>> call(CreateTodoParams params) async {
    return await todoRepository.createTodo(params.todo);
  }
}

class CreateTodoParams {
  final ToDo todo;

  CreateTodoParams(this.todo);
}
