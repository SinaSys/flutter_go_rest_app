import 'package:clean_architecture_getx/common/usecase/usecase.dart';
import 'package:clean_architecture_getx/features/user/data/models/user.dart';
import 'package:clean_architecture_getx/features/user/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';


class DeleteUserUseCase implements UseCase<bool, DeleteUserParams> {
  final UserRepository userRepository;

  const DeleteUserUseCase(this.userRepository);

  @override
  Future<Either<String, bool>> call(DeleteUserParams params) async {
    return await userRepository.deleteUser(params.user);
  }
}

class DeleteUserParams {
  final User user;

  DeleteUserParams(this.user);
}
