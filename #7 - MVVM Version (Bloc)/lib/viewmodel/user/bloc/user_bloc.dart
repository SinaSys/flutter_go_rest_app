import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repository/user/user_repository.dart';
import '../bloc/user_event.dart';

import '../../../common/bloc/bloc_helper.dart';
import '../../../common/bloc/generic_bloc_state.dart';
import '../../../data/model/user/user.dart';

typedef Emit = Emitter<GenericBlocState<User>>;

class UserBloc extends Bloc<UserEvent, GenericBlocState<User>>
    with BlocHelper<User> {
  UserBloc({required this.userRepository}) : super(GenericBlocState.loading()) {
    on<UsersFetched>(getUserList);
    on<UserCreated>(createUser);
    on<UserUpdated>(updateUser);
    on<UserDeleted>(deleteUser);
  }

  //final UserApi _userApi = UserApi();
  final UserRepository userRepository;

  Future<void> getUserList(UsersFetched event, Emit emit) async {
    operation = ApiOperation.select;
    await getItems(userRepository.getUsers(gender: event.gender, status: event.status), emit);
  }

  Future<void> createUser(UserCreated event, Emit emit) async {
    operation = ApiOperation.create;
    await createItem(userRepository.createUser(event.user), emit);
  }

  Future<void> updateUser(UserUpdated event, Emit emit) async {
    operation = ApiOperation.update;
    await updateItem(userRepository.updateUser(event.user), emit);
  }

  Future<void> deleteUser(UserDeleted event, Emit emit) async {
    operation = ApiOperation.delete;
    await deleteItem(userRepository.deleteUser(event.user), emit);
  }
}
