import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:clean_architecture_getx/features/user/data/models/user.dart';
import 'package:clean_architecture_getx/common/controller/base_controller.dart';
import 'package:clean_architecture_getx/features/user/domain/entities/user_entity.dart';
import 'package:clean_architecture_getx/features/user/domain/usecases/create_user_usecase.dart';
import 'package:clean_architecture_getx/features/user/domain/usecases/delete_user_usecase.dart';
import 'package:clean_architecture_getx/features/user/domain/usecases/get_users_usecase.dart';
import 'package:clean_architecture_getx/features/user/domain/usecases/update_user_usecase.dart';

class UserController extends GetxController with StateMixin<List<User>>, BaseController {
  final GetUsersUseCase getUsersUseCase;
  final CreateUserUseCase createUserUseCase;
  final UpdateUserUseCase updateUserUseCase;
  final DeleteUserUseCase deleteUserUseCase;

  @visibleForTesting
  Either<String, List<User>>? failureOrSuccess;

  UserController({
    required this.getUsersUseCase,
    required this.createUserUseCase,
    required this.updateUserUseCase,
    required this.deleteUserUseCase,
  });

  Future<void> createUser(User user) async {
    createItem(createUserUseCase.call(CreateUserParams(user)));
  }

  Future<void> updateUser(User user) async {
    updateItem(updateUserUseCase.call(UpdateUserParams(user)));
  }

  Future<void> deleteUser(User user) async {
    deleteItem(deleteUserUseCase.call(DeleteUserParams(user)));
  }

  Future<void> getUserList({
    Gender gender = Gender.all,
    UserStatus status = UserStatus.all,
  }) async {
    change(null, status: RxStatus.loading());
    failureOrSuccess = (await getUsersUseCase.call(
      GetUsersParams(status: status, gender: gender),
    ));

    failureOrSuccess!.fold(
      (String failure) {
        change(null, status: RxStatus.error(failure));
      },
      (List<User> users) {
        if (users.isEmpty) {
          change(null, status: RxStatus.empty());
        } else {
          change(users, status: RxStatus.success());
        }
      },
    );
  }
}
