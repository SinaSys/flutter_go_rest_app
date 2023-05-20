import 'package:clean_architecture_rxdart/common/usecase/usecase.dart';
import 'package:clean_architecture_rxdart/common/network/api_result.dart';
import 'package:clean_architecture_rxdart/features/user/data/models/user.dart';
import 'package:clean_architecture_rxdart/features/user/domain/repositories/user_repository.dart';

class CreateUserUseCase implements UseCase<bool, CreateUserParams> {
  final UserRepository userRepository;

  const CreateUserUseCase(this.userRepository);

  @override
  Future<ApiResult<bool>> call(CreateUserParams params) async {
    return await userRepository.createUser(params.user);
  }
}

class CreateUserParams {
  final User user;

  const CreateUserParams(this.user);
}
