import 'package:clean_architecture_rxdart/common/usecase/usecase.dart';
import 'package:clean_architecture_rxdart/common/network/api_result.dart';
import 'package:clean_architecture_rxdart/features/user/data/models/user.dart';
import 'package:clean_architecture_rxdart/features/user/domain/repositories/user_repository.dart';

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

  const UpdateUserParams(this.user);
}
