import 'package:clean_architecture_bloc/common/network/api_result.dart';
import 'package:clean_architecture_bloc/features/user/domain/repositories/user_repository.dart';

import '../../../../common/usecase/usecase.dart';
import '../../data/models/user.dart';
import '../entities/user_entity.dart';

class GetUsersUseCase implements UseCase<List<User>, GetUsersParams> {
  final UserRepository userRepository;

  const GetUsersUseCase(this.userRepository);

  @override
  Future<ApiResult<List<User>>> call(GetUsersParams params) async {
    return await userRepository.getUsers(status: params.status, gender: params.gender);
  }
}

class GetUsersParams {
  final Gender? gender;
  final UserStatus? status;

  GetUsersParams({this.gender, this.status});
}
