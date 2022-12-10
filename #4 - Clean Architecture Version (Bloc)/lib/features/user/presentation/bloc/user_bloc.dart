import 'package:clean_architecture_bloc/common/bloc/bloc_helper.dart';
import 'package:clean_architecture_bloc/features/user/domain/usecases/create_user_usecase.dart';
import 'package:clean_architecture_bloc/features/user/domain/usecases/delete_user_usecase.dart';
import 'package:clean_architecture_bloc/features/user/domain/usecases/get_users_usecase.dart';
import 'package:clean_architecture_bloc/features/user/domain/usecases/update_user_usecase.dart';
import 'package:clean_architecture_bloc/features/user/presentation/bloc/user_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/bloc/generic_bloc_state.dart';
import '../../data/models/user.dart';

typedef Emit = Emitter<GenericBlocState<User>>;

class UserBloc extends Bloc<UserEvent, GenericBlocState<User>> with BlocHelper<User> {
  UserBloc({
    required this.getUsersUseCase,
    required this.createUserUseCase,
    required this.updateUserUseCase,
    required this.deleteUserUseCase,
  }) : super(GenericBlocState.loading()) {
    on<UsersFetched>(getUserList);
    on<UserCreated>(createUser);
    on<UserUpdated>(updateUser);
    on<UserDeleted>(deleteUser);
  }

  final GetUsersUseCase getUsersUseCase;
  final CreateUserUseCase createUserUseCase;
  final UpdateUserUseCase updateUserUseCase;
  final DeleteUserUseCase deleteUserUseCase;

  Future<void> getUserList(UsersFetched event, Emit emit) async {
    operation = ApiOperation.select;
    await getItems(getUsersUseCase.call(GetUsersParams(status: event.status, gender: event.gender)), emit);
  }

  Future<void> createUser(UserCreated event, Emit emit) async {
    operation = ApiOperation.create;
    await createItem(createUserUseCase.call(CreateUserParams(event.user)), emit);
  }

  Future<void> updateUser(UserUpdated event, Emit emit) async {
    operation = ApiOperation.update;
    await updateItem(updateUserUseCase.call(UpdateUserParams(event.user)), emit);
  }

  Future<void> deleteUser(UserDeleted event, Emit emit) async {
    operation = ApiOperation.delete;
    await deleteItem(deleteUserUseCase.call(DeleteUserParams(event.user)), emit);
  }
}
