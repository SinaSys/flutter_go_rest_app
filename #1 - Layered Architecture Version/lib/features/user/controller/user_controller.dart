import 'package:dartz/dartz.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../../../common/controller/api_operation.dart';
import '../data/model/user.dart';
import '../data/provider/remote/user_api.dart';

class UserController extends GetxController
    with StateMixin<List<User>>, ApiOperationMixin {
  final UserApi _userApi = UserApi();

  @override
  void onInit() {
    getUserList();
    super.onInit();
  }

  Future<void> getUserList(
      {Gender gender = Gender.all, UserStatus status = UserStatus.all}) async {
    change(null, status: RxStatus.loading());
    Either<String, List<User>> failureOrSuccess =
        (await _userApi.getUserList(gender: gender, status: status));

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

  void createUser(User user) {
    requestMethodTemplate(_userApi.createUser(user));
  }

  void deleteUser(User user) {
    requestMethodTemplate(_userApi.deleteUser(user));
  }

  void updateUser(User user) {
    requestMethodTemplate(_userApi.updateUser(user));
  }
}
