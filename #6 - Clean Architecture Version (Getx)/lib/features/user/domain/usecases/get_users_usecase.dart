import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:clean_architecture_getx/common/usecase/usecase.dart';
import 'package:clean_architecture_getx/features/user/data/models/user.dart';
import 'package:clean_architecture_getx/features/user/domain/entities/user_entity.dart';
import 'package:clean_architecture_getx/features/user/domain/repositories/user_repository.dart';

@immutable
class GetUsersUseCase implements UseCase<List<User>, GetUsersParams> {
  final UserRepository userRepository;

  const GetUsersUseCase(this.userRepository);

  @override
  Future<Either<String, List<User>>> call(GetUsersParams params) async {
    return await userRepository.getUsers(
        status: params.status, gender: params.gender);
  }
}

@immutable
class GetUsersParams {
  final Gender? gender;
  final UserStatus? status;

  const GetUsersParams({this.gender, this.status});
}
