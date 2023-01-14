import 'package:clean_architecture_cubit/common/network/api_result.dart';
import 'package:clean_architecture_cubit/common/usecase/usecase.dart';
import 'package:clean_architecture_cubit/features/user/data/models/user.dart';
import 'package:clean_architecture_cubit/features/user/domain/repositories/user_repository.dart';

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
