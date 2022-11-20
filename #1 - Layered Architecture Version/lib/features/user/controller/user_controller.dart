import 'package:dartz/dartz.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../data/model/user.dart';
import '../data/provider/remote/user_api.dart';

enum StatusX { loading, success, error }

class UserController extends GetxController with StateMixin<List<User>> {
  final UserApi _userApi = UserApi();
  Rx<String> errorMessage = "".obs;
  Rx<StatusX> dialogStatus = StatusX.loading.obs;

  @override
  void onInit() {
    getUserList();
    super.onInit();
  }

  Future<bool> getUserList(
      {Gender gender = Gender.all, UserStatus status = UserStatus.all}) async {
    change(null, status: RxStatus.loading());
    Either<String, List<User>> failureOrSuccess =
        (await _userApi.getUserList(gender: gender, status: status));

    failureOrSuccess.fold(
      (String failure) {
        change(null, status: RxStatus.error(failure));
        return false;
      },
      (List<User> users) {
        if (users.isEmpty) {
          change(null, status: RxStatus.empty());
        } else {
          change(users, status: RxStatus.success());
        }
        return true;
      },
    );
    return false;
  }

  Future<bool> createUser(User user) async {
    dialogStatus.value = StatusX.loading;
    Either<String, bool> failureOrSuccess = (await _userApi.createUser(user));
    failureOrSuccess.fold(
      (String failure) {
        dialogStatus.value = StatusX.error;
        errorMessage = failure.obs;
        return false;
      },
      (bool success) {
        dialogStatus.value = StatusX.success;
        return true;
      },
    );
    return false;
  }

  Future<bool> deleteUser(User user) async {
    dialogStatus.value = StatusX.loading;
    Either<String, bool> failureOrSuccess = (await _userApi.deleteUser(user));

    failureOrSuccess.fold(
      (String failure) {
        dialogStatus.value = StatusX.error;
        errorMessage = failure.obs;
        return false;
      },
      (bool success) {
        dialogStatus.value = StatusX.success;
        return true;
      },
    );

    return false;
  }

  Future<bool> updateUser(User user) async {
    dialogStatus.value = StatusX.loading;
    Either<String, bool> failureOrSuccess = (await _userApi.updateUser(user));

    failureOrSuccess.fold(
      (String failure) {
        dialogStatus.value = StatusX.error;
        errorMessage = failure.obs;
        return false;
      },
      (bool success) {
        dialogStatus.value = StatusX.success;
        return true;
      },
    );

    return false;
  }
}
