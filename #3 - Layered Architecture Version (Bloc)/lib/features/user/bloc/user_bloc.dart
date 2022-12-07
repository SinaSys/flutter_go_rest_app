import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:layered_architecture_bloc/features/user/bloc/user_event.dart';

import '../../../common/bloc/bloc_helper.dart';
import '../../../common/bloc/generic_bloc_state.dart';
import '../data/model/user.dart';
import '../data/provider/remote/user_api.dart';

typedef Emit = Emitter<GenericBlocState<User>>;

class UserBloc extends Bloc<UserEvent, GenericBlocState<User>> with BlocHelper<User> {
  UserBloc() : super(GenericBlocState.loading()) {
    on<UsersFetched>(getUserList);
    on<UserCreated>(createUser);
    on<UserUpdated>(updateUser);
    on<UserDeleted>(deleteUser);
  }

  final UserApi _userApi = UserApi();

  Future<void> getUserList(UsersFetched event, Emit emit) async {
    operation = ApiOperation.select;
    await getItems(_userApi.getUserList(gender: event.gender, status: event.status), emit);
  }

  Future<void> createUser(UserCreated event, Emit emit) async {
    operation = ApiOperation.create;
    await createItem(_userApi.createUser(event.user), emit);
  }

  Future<void> updateUser(UserUpdated event, Emit emit) async {
    operation = ApiOperation.update;
    await updateItem(_userApi.updateUser(event.user), emit);
  }

  Future<void> deleteUser(UserDeleted event, Emit emit) async {
    operation = ApiOperation.delete;
    await deleteItem(_userApi.deleteUser(event.user), emit);
  }
}
