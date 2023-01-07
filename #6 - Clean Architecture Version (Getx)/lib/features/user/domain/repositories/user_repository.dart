import 'package:dartz/dartz.dart';

import '../../data/models/user.dart';
import '../entities/user_entity.dart';

abstract class UserRepository {
  Future<Either<String, List<User>>> getUsers(
      {Gender? gender, UserStatus? status});

  Future<Either<String, bool>> createUser(User user);

  Future<Either<String, bool>> updateUser(User user);

  Future<Either<String, bool>> deleteUser(User user);
}
