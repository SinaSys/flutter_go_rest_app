import 'package:clean_architecture_getx/features/user/data/models/user.dart';
import 'package:clean_architecture_getx/features/user/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';



abstract class UserRepository {
  Future<Either<String, List<User>>> getUsers({Gender? gender, UserStatus? status});

  Future<Either<String, bool>> createUser(User user);

  Future<Either<String, bool>> updateUser(User user);

  Future<Either<String, bool>> deleteUser(User user);
}
