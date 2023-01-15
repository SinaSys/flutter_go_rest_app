import 'package:mvvm_getx/common/repository/repository_helper.dart';
import 'package:mvvm_getx/data/api/user/user_api.dart';
import 'package:mvvm_getx/data/model/user/user.dart';
import 'package:dartz/dartz.dart';

class UserRepository with RepositoryHelper<User> {
  final UserApi userApi;

  UserRepository({required this.userApi});

  Future<Either<String, List<User>>> getUsers({Gender? gender, UserStatus? status}) async {
    return checkItemsFailOrSuccess(userApi.getUsers(gender: gender, status: status));
  }

  Future<Either<String, bool>> createUser(User user) async {
    return checkItemFailOrSuccess(userApi.createUser(user));
  }

  Future<Either<String, bool>> updateUser(User user) async {
    return checkItemFailOrSuccess(userApi.updateUser(user));
  }

  Future<Either<String, bool>> deleteUser(User user) async {
    return checkItemFailOrSuccess(userApi.deleteUser(user));
  }
}
