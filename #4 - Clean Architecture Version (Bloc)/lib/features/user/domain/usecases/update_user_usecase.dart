import 'package:clean_architecture_bloc/common/network/api_result.dart';

import '../../../../common/usecase/usecase.dart';
import '../../data/models/user.dart';
import '../repositories/user_repository.dart';

class UpdateUserUseCase implements UseCase<bool, UpdateUserParams> {
  final UserRepository userRepository;

  const UpdateUserUseCase(this.userRepository);

  @override
  Future<ApiResult<bool>> call(UpdateUserParams params) async {
    return await userRepository.updateUser(params.user);
  }
}

class UpdateUserParams {
  final User user;

  UpdateUserParams(this.user);
}
