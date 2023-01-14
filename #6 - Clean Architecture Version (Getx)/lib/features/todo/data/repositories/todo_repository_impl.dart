import 'package:clean_architecture_getx/features/todo/data/datasources/todo_remote_data_source.dart';
import 'package:clean_architecture_getx/features/todo/domain/repositories/todo_repository.dart';
import 'package:clean_architecture_getx/features/todo/domain/entities/todo_entity.dart';
import 'package:clean_architecture_getx/common/repository/repository_helper.dart';
import 'package:clean_architecture_getx/features/todo/data/models/todo.dart';
import 'package:dartz/dartz.dart';

class TodoRepositoryImpl extends TodoRepository with RepositoryHelper<ToDo> {
  final TodoRemoteDataSource remoteDataSource;

  TodoRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<String, List<ToDo>>> getTodos(int userId, {TodoStatus? status}) async {
    return checkItemsFailOrSuccess(remoteDataSource.getTodos(userId, status: status));
  }

  @override
  Future<Either<String, bool>> createTodo(ToDo todo) async {
    return checkItemFailOrSuccess(remoteDataSource.createTodo(todo));
  }

  @override
  Future<Either<String, bool>> updateTodo(ToDo todo) async {
    return checkItemFailOrSuccess(remoteDataSource.updateTodo(todo));
  }

  @override
  Future<Either<String, bool>> deleteTodo(ToDo todo) async {
    return checkItemFailOrSuccess(remoteDataSource.deleteTodo(todo));
  }
}
