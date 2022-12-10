import 'package:clean_architecture_bloc/common/network/api_result.dart';

import '../../../../common/usecase/usecase.dart';
import '../../data/models/user.dart';
import '../repositories/user_repository.dart';

class DeleteUserUseCase implements UseCase<bool, DeleteUserParams> {
  final UserRepository userRepository;

  const DeleteUserUseCase(this.userRepository);

  @override
  Future<ApiResult<bool>> call(DeleteUserParams params) async {
    return await userRepository.deleteUser(params.user);
  }
}

class DeleteUserParams {
  final User user;

  DeleteUserParams(this.user);
}
