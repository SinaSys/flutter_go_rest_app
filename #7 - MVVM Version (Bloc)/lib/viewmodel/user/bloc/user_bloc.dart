import 'package:mvvm_bloc/viewmodel/user/bloc/user_event.dart';
import 'package:mvvm_bloc/common/bloc/generic_bloc_state.dart';
import 'package:mvvm_bloc/repository/user/user_repository.dart';
import 'package:mvvm_bloc/common/bloc/bloc_helper.dart';
import 'package:mvvm_bloc/data/model/user/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef Emit = Emitter<GenericBlocState<User>>;

class UserBloc extends Bloc<UserEvent, GenericBlocState<User>> with BlocHelper<User> {
  UserBloc({required this.userRepository}) : super(GenericBlocState.loading()) {
    on<UsersFetched>(getUserList);
    on<UserCreated>(createUser);
    on<UserUpdated>(updateUser);
    on<UserDeleted>(deleteUser);
  }

  final UserRepository userRepository;

  Future<void> getUserList(UsersFetched event, Emit emit) async {
    await getItems(userRepository.getUsers(gender: event.gender, status: event.status), emit);
  }

  Future<void> createUser(UserCreated event, Emit emit) async {
    await createItem(userRepository.createUser(event.user), emit);
  }

  Future<void> updateUser(UserUpdated event, Emit emit) async {
    await updateItem(userRepository.updateUser(event.user), emit);
  }

  Future<void> deleteUser(UserDeleted event, Emit emit) async {
    await deleteItem(userRepository.deleteUser(event.user), emit);
  }
}
