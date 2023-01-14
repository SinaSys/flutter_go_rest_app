import 'package:layered_architecture_cubit/features/user/data/provider/remote/user_api.dart';
import 'package:layered_architecture_cubit/features/user/data/model/user.dart';
import 'package:layered_architecture_cubit/common/cubit/generic_cubit.dart';

class UserCubit extends GenericCubit<User> {
  final UserApi userApi = UserApi();

  Future<void> createUser(User user) async {
    createItem(userApi.createUser(user));
  }

  Future<void> updateUser(User user) async {
    updateItem(userApi.updateUser(user));
  }

  Future<void> deleteUser(User user) async {
    deleteItem(userApi.deleteUser(user));
  }

  Future<void> getUserList({
    Gender gender = Gender.all,
    UserStatus status = UserStatus.all,
  }) async {
    getItems(userApi.getUserList(gender: gender, status: status));
  }
}
