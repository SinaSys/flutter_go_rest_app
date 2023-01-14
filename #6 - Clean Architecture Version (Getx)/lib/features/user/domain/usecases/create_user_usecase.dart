import 'package:clean_architecture_getx/common/usecase/usecase.dart';
import 'package:clean_architecture_getx/features/user/data/models/user.dart';
import 'package:clean_architecture_getx/features/user/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class CreateUserUseCase implements UseCase<bool, CreateUserParams> {
  final UserRepository userRepository;

  const CreateUserUseCase(this.userRepository);

  @override
  Future<Either<String, bool>> call(CreateUserParams params) async {
    return await userRepository.createUser(params.user);
  }
}

class CreateUserParams {
  final User user;

  CreateUserParams(this.user);
}
