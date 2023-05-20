import 'package:clean_architecture_rxdart/common/usecase/usecase.dart';
import 'package:clean_architecture_rxdart/common/network/api_result.dart';
import 'package:clean_architecture_rxdart/features/todo/data/models/todo.dart';
import 'package:clean_architecture_rxdart/features/todo/domain/repositories/todo_repository.dart';

class CreateTodoUseCase implements UseCase<bool, CreateTodoParams> {
  final TodoRepository todoRepository;

  const CreateTodoUseCase(this.todoRepository);

  @override
  Future<ApiResult<bool>> call(CreateTodoParams params) async {
    return await todoRepository.createTodo(params.todo);
  }
}

class CreateTodoParams {
  final ToDo todo;

  const CreateTodoParams(this.todo);
}
