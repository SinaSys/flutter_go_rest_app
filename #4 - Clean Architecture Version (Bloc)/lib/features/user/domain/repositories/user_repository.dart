import 'package:clean_architecture_bloc/common/network/api_result.dart';

import '../../data/models/user.dart';
import '../entities/user_entity.dart';

abstract class UserRepository {
  Future<ApiResult<List<User>>> getUsers({Gender? gender, UserStatus? status});

  Future<ApiResult<bool>> createUser(User user);

  Future<ApiResult<bool>> updateUser(User user);

  Future<ApiResult<bool>> deleteUser(User user);
}
