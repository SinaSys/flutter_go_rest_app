import 'package:clean_architecture_getx/common/usecase/usecase.dart';
import 'package:clean_architecture_getx/features/user/data/models/user.dart';
import 'package:clean_architecture_getx/features/user/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateUserUseCase implements UseCase<bool, UpdateUserParams> {
  final UserRepository userRepository;

  const UpdateUserUseCase(this.userRepository);

  @override
  Future<Either<String, bool>> call(UpdateUserParams params) async {
    return await userRepository.updateUser(params.user);
  }
}

class UpdateUserParams {
  final User user;

  UpdateUserParams(this.user);
}
