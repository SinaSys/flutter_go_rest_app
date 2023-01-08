import '../../../../common/cubit/generic_cubit.dart';
import '../../../data/model/user/user.dart';
import '../../../repository/user/user_repository.dart';

class UserCubit extends GenericCubit<User> {
  final UserRepository userRepository;

  UserCubit({required this.userRepository});

  Future<void> getUserList({
    Gender gender = Gender.all,
    UserStatus status = UserStatus.all,
  }) async {
    operation = ApiOperation.select;
    getItems(userRepository.getUsers(status: status, gender: gender));
  }

  Future<void> createUser(User user) async {
    operation = ApiOperation.create;
    createItem(userRepository.createUser(user));
  }

  Future<void> updateUser(User user) async {
    operation = ApiOperation.update;
    updateItem(userRepository.updateUser(user));
  }

  Future<void> deleteUser(User user) async {
    operation = ApiOperation.delete;
    deleteItem(userRepository.deleteUser(user));
  }
}
