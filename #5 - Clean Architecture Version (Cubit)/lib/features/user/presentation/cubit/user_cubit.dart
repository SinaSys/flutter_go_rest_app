import 'package:clean_architecture_cubit/common/cubit/generic_cubit.dart';
import 'package:clean_architecture_cubit/features/user/data/models/user.dart';
import 'package:clean_architecture_cubit/features/user/domain/entities/user_entity.dart';
import 'package:clean_architecture_cubit/features/user/domain/usecases/create_user_usecase.dart';
import 'package:clean_architecture_cubit/features/user/domain/usecases/delete_user_usecase.dart';
import 'package:clean_architecture_cubit/features/user/domain/usecases/get_users_usecase.dart';
import 'package:clean_architecture_cubit/features/user/domain/usecases/update_user_usecase.dart';

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
    getItems(getUsersUseCase.call(GetUsersParams(status: status, gender: gender)));
  }
}
