import 'package:clean_architecture_rxdart/common/network/api_result.dart';
import 'package:clean_architecture_rxdart/features/user/data/models/user.dart';
import 'package:clean_architecture_rxdart/common/repository/repository_helper.dart';
import 'package:clean_architecture_rxdart/features/user/domain/entities/user_entity.dart';
import 'package:clean_architecture_rxdart/features/user/domain/repositories/user_repository.dart';
import 'package:clean_architecture_rxdart/features/user/data/datasources/user_remote_data_source.dart';

class UserRepositoryImpl extends UserRepository with RepositoryHelper<User> {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ApiResult<List<User>>> getUsers(
      {Gender? gender, UserStatus? status}) async {
    return checkItemsFailOrSuccess(
        remoteDataSource.getUsers(gender: gender, status: status));
  }

  @override
  Future<ApiResult<bool>> createUser(User user) async {
    return checkItemFailOrSuccess(remoteDataSource.createUser(user));
  }

  @override
  Future<ApiResult<bool>> updateUser(User user) async {
    return checkItemFailOrSuccess(remoteDataSource.updateUser(user));
  }

  @override
  Future<ApiResult<bool>> deleteUser(User user) async {
    return checkItemFailOrSuccess(remoteDataSource.deleteUser(user));
  }
}
