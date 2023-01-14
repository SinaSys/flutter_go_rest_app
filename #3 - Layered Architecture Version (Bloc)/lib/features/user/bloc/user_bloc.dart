import 'package:layered_architecture_bloc/features/user/data/provider/remote/user_api.dart';
import 'package:layered_architecture_bloc/common/bloc/generic_bloc_state.dart';
import 'package:layered_architecture_bloc/features/user/bloc/user_event.dart';
import 'package:layered_architecture_bloc/features/user/data/model/user.dart';
import 'package:layered_architecture_bloc/common/bloc/bloc_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef Emit = Emitter<GenericBlocState<User>>;

class UserBloc extends Bloc<UserEvent, GenericBlocState<User>> with BlocHelper<User> {
  UserBloc() : super(GenericBlocState.loading()) {
    on<UsersFetched>(getUserList);
    on<UserCreated>(createUser);
    on<UserUpdated>(updateUser);
    on<UserDeleted>(deleteUser);
  }

  final UserApi userApi = UserApi();

  Future<void> getUserList(UsersFetched event, Emit emit) async {
    await getItems(userApi.getUserList(gender: event.gender, status: event.status), emit);
  }

  Future<void> createUser(UserCreated event, Emit emit) async {
    await createItem(userApi.createUser(event.user), emit);
  }

  Future<void> updateUser(UserUpdated event, Emit emit) async {
    await updateItem(userApi.updateUser(event.user), emit);
  }

  Future<void> deleteUser(UserDeleted event, Emit emit) async {
    await deleteItem(userApi.deleteUser(event.user), emit);
  }
}
