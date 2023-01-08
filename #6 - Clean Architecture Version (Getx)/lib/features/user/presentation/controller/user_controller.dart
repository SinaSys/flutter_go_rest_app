import 'package:dartz/dartz.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../../common/controller/base_controller.dart';
import '../../data/models/user.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/create_user_usecase.dart';
import '../../domain/usecases/delete_user_usecase.dart';
import '../../domain/usecases/get_users_usecase.dart';
import '../../domain/usecases/update_user_usecase.dart';

class UserController extends GetxController with StateMixin<List<User>>, BaseController {
  final GetUsersUseCase getUsersUseCase;
  final CreateUserUseCase createUserUseCase;
  final UpdateUserUseCase updateUserUseCase;
  final DeleteUserUseCase deleteUserUseCase;

  UserController({
    required this.getUsersUseCase,
    required this.createUserUseCase,
    required this.updateUserUseCase,
    required this.deleteUserUseCase,
  });


  void createUser(User user) {
    createItem(createUserUseCase.call(CreateUserParams(user)));
  }

  void updateUser(User user) {
    updateItem(updateUserUseCase.call(UpdateUserParams(user)));
  }

  void deleteUser(User user) {
    deleteItem(deleteUserUseCase.call(DeleteUserParams(user)));
  }

  Future<void> getUserList({Gender gender = Gender.all, UserStatus status = UserStatus.all}) async {
    change(null, status: RxStatus.loading());
    final Either<String, List<User>> failureOrSuccess = (await getUsersUseCase
        .call(GetUsersParams(status: status, gender: gender)));

    failureOrSuccess.fold(
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
