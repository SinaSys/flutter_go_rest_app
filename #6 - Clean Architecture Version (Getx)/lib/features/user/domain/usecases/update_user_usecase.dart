import 'package:dartz/dartz.dart';

import '../../../../common/usecase/usecase.dart';
import '../../data/models/user.dart';
import '../repositories/user_repository.dart';

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
