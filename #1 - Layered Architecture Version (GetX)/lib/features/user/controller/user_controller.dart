import 'package:layered_architecture/features/user/data/provider/remote/user_api.dart';
import 'package:layered_architecture/common/controller/base_controller.dart';
import 'package:layered_architecture/features/user/data/model/user.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:dartz/dartz.dart';

class UserController extends GetxController with StateMixin<List<User>>, BaseController {
  final UserApi userApi = UserApi();

  @override
  void onInit() {
    getUserList();
    super.onInit();
  }

  void createUser(User user) {
    createItem(userApi.createUser(user));
  }

  void updateUser(User user) {
    updateItem(userApi.updateUser(user));
  }

  void deleteUser(User user) {
    deleteItem(userApi.deleteUser(user));
  }

  Future<void> getUserList({
    Gender gender = Gender.all,
    UserStatus status = UserStatus.all,
  }) async {
    change(null, status: RxStatus.loading());

    Either<String, List<User>> failureOrSuccess =
        (await userApi.getUserList(gender: gender, status: status));

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
