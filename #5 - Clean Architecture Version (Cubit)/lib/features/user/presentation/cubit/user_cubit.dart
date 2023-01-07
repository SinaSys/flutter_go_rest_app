import '../../../../common/cubit/generic_cubit.dart';
import '../../data/models/user.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/create_user_usecase.dart';
import '../../domain/usecases/delete_user_usecase.dart';
import '../../domain/usecases/get_users_usecase.dart';
import '../../domain/usecases/update_user_usecase.dart';

class UserCubit extends GenericCubit<User> {
  final GetUsersUseCase getUsersUseCase;
  final CreateUserUseCase createUserUseCase;
  final UpdateUserUseCase updateUserUseCase;
  final DeleteUserUseCase deleteUserUseCase;

  UserCubit({
    required this.getUsersUseCase,
    required this.createUserUseCase,
    required this.updateUserUseCase,
    required this.deleteUserUseCase,
  });

  Future<void> createUser(User user) async {
    operation = ApiOperation.create;
    createItem(createUserUseCase.call(CreateUserParams(user)));
  }

  Future<void> updateUser(User user) async {
    operation = ApiOperation.update;
    updateItem(updateUserUseCase.call(UpdateUserParams(user)));
  }

  Future<void> deleteUser(User user) async {
    operation = ApiOperation.delete;
    deleteItem(deleteUserUseCase.call(DeleteUserParams(user)));
  }

  Future<void> getUserList({
    Gender gender = Gender.all,
    UserStatus status = UserStatus.all,
  }) async {
    operation = ApiOperation.select;
    getItems(getUsersUseCase.call(GetUsersParams(status: status, gender: gender)));
  }
}
