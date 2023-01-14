import 'package:clean_architecture_getx/common/usecase/usecase.dart';
import 'package:clean_architecture_getx/features/user/data/models/user.dart';
import 'package:clean_architecture_getx/features/user/domain/entities/user_entity.dart';
import 'package:clean_architecture_getx/features/user/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class GetUsersUseCase implements UseCase<List<User>, GetUsersParams> {
  final UserRepository userRepository;

  const GetUsersUseCase(this.userRepository);

  @override
  Future<Either<String, List<User>>> call(GetUsersParams params) async {
    return await userRepository.getUsers(
        status: params.status, gender: params.gender);
  }
}

class GetUsersParams {
  final Gender? gender;
  final UserStatus? status;

  GetUsersParams({this.gender, this.status});
}
