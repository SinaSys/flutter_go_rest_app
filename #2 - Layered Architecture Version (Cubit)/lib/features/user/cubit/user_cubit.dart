import '../../../common/cubit/generic_cubit.dart';
import '../data/model/user.dart';
import '../data/provider/remote/user_api.dart';

enum ApiOperation { select, create, update, delete }

class UserCubit extends GenericCubit<User> {
  final UserApi _userApi = UserApi();

  Future<void> getUserList({
    Gender gender = Gender.all,
    UserStatus status = UserStatus.all,
  }) async {
    operation = ApiOperation.select;
    getItems(_userApi.getUserList(gender: gender, status: status));
  }

  Future<void> createUser(User user) async {
    operation = ApiOperation.create;
    createItem(_userApi.createUser(user));
  }

  Future<void> deleteUser(User user) async {
    operation = ApiOperation.delete;
    deleteItem(_userApi.deleteUser(user));
  }

  Future<void> updateUser(User user) async {
    operation = ApiOperation.update;
    updateItem(_userApi.updateUser(user));
  }
}
