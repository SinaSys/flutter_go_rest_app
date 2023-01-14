import 'package:clean_architecture_bloc/common/network/api_result.dart';
import 'package:clean_architecture_bloc/common/repository/repository_helper.dart';
import 'package:clean_architecture_bloc/features/todo/data/datasources/todo_remote_data_source.dart';
import 'package:clean_architecture_bloc/features/todo/data/models/todo.dart';
import 'package:clean_architecture_bloc/features/todo/domain/entities/todo_entity.dart';
import 'package:clean_architecture_bloc/features/todo/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl extends TodoRepository with RepositoryHelper<ToDo> {
  final TodoRemoteDataSource remoteDataSource;

  TodoRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ApiResult<List<ToDo>>> getTodos(int userId, {TodoStatus? status}) async {
    return checkItemsFailOrSuccess(remoteDataSource.getTodos(userId, status: status));
  }

  @override
  Future<ApiResult<bool>> createTodo(ToDo todo) async {
    return checkItemFailOrSuccess(remoteDataSource.createTodo(todo));
  }

  @override
  Future<ApiResult<bool>> updateTodo(ToDo todo) async {
    return checkItemFailOrSuccess(remoteDataSource.updateTodo(todo));
  }

  @override
  Future<ApiResult<bool>> deleteTodo(ToDo todo) async {
    return checkItemFailOrSuccess(remoteDataSource.deleteTodo(todo));
  }
}
