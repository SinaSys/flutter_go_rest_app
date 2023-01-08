import 'package:dartz/dartz.dart';

import '../../common/repository/repository_helper.dart';
import '../../data/api/user/user_api.dart';
import '../../data/model/user/user.dart';

class UserRepository with RepositoryHelper<User> {
  final UserApi userApi;

  UserRepository({required this.userApi});

  Future<Either<String, List<User>>> getUsers(
      {Gender? gender, UserStatus? status}) async {
    return checkItemsFailOrSuccess(
        userApi.getUsers(gender: gender, status: status));
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
