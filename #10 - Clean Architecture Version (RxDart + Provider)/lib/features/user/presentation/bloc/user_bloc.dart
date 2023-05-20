import 'package:rxdart/rxdart.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:clean_architecture_rxdart/common/network/api_result.dart';
import 'package:clean_architecture_rxdart/common/bloc/generic_bloc_state.dart';
import 'package:clean_architecture_rxdart/features/user/data/models/user.dart';
import 'package:clean_architecture_rxdart/features/user/presentation/bloc/user_event.dart';
import 'package:clean_architecture_rxdart/features/user/domain/usecases/get_users_usecase.dart';
import 'package:clean_architecture_rxdart/features/user/domain/usecases/create_user_usecase.dart';
import 'package:clean_architecture_rxdart/features/user/domain/usecases/delete_user_usecase.dart';
import 'package:clean_architecture_rxdart/features/user/domain/usecases/update_user_usecase.dart';

@immutable
class UserBloc {
  factory UserBloc({
    required getUsersUseCase,
    required createUserUseCase,
    required updateUserUseCase,
    required deleteUserUseCase,
  }) {
    final BehaviorSubject<UsersFetched> refreshUserList =
        BehaviorSubject<UsersFetched>();

    final BehaviorSubject<User> createUser = BehaviorSubject<User>();

    final BehaviorSubject<User> updateUser = BehaviorSubject<User>();

    final BehaviorSubject<User> deleteUser = BehaviorSubject<User>();

    final Stream<GenericBlocState<User>> userList = refreshUserList.switchMap(
      (UsersFetched input) {
        return Rx.fromCallable<ApiResult<List<User>>>(
          () async => await getUsersUseCase.call(
            GetUsersParams(status: input.status, gender: input.gender),
          ),
        ).asyncMap<GenericBlocState<User>>((result) {
          return result.when(
            success: (List<User> items) async {
              if (items.isEmpty) {
                return GenericBlocState.empty();
              } else {
                return GenericBlocState.success(items);
              }
            },
            failure: (String failure) async {
              return GenericBlocState.failure(failure);
            },
          );
        });
      },
    ).startWith(GenericBlocState.loading());

    final Stream<GenericBlocState<bool>> isUserDeleted =
        deleteUser.flatMap((user) {
      return Rx.fromCallable<ApiResult<bool>>(
        () async {
          return await deleteUserUseCase.call(DeleteUserParams(user));
        },
      ); // Return Stream<ApiResult<bool>>
    }).asyncMap<GenericBlocState<bool>>(
      (result) {
        return result.when(
          success: (_) async {
            refreshUserList.add(const UsersFetched());
            return GenericBlocState.success(null);
          },
          failure: (String failure) async {
            return GenericBlocState.failure(failure);
          },
        );
      },
    );

    final Stream<GenericBlocState<bool>> isUserUpdated = updateUser.flatMap(
      (user) {
        return Rx.fromCallable<ApiResult<bool>>(
          () async {
            return await updateUserUseCase.call(UpdateUserParams(user));
          },
        );
      }, // Return Stream<ApiResult<bool>>
    ).asyncMap<GenericBlocState<bool>>(
      (result) {
        return result.when(
          success: (_) async {
            refreshUserList.add(const UsersFetched());
            return GenericBlocState.success(null);
          },
          failure: (String failure) async {
            return GenericBlocState.failure(failure);
          },
        );
      },
    );

    final isUserCreated = createUser.flatMap(
      (user) {
        return Rx.fromCallable<ApiResult<bool>>(
          () {
            return createUserUseCase.call(CreateUserParams(user));
          },
        ); // Return Stream<ApiResult<bool>>
      },
    ).asyncMap<GenericBlocState<bool>>(
      (result) {
        return result.when(
          success: (_) async {
            refreshUserList.add(const UsersFetched());
            return GenericBlocState.success(null);
          },
          failure: (String failure) async {
            return GenericBlocState.failure(failure);
          },
        );
      },
    );

    return UserBloc._(
      getUsersUseCase: getUsersUseCase,
      createUserUseCase: createUserUseCase,
      updateUserUseCase: updateUserUseCase,
      deleteUserUseCase: deleteUserUseCase,
      userList: userList,
      deleteUser: deleteUser,
      isUserDeleted: isUserDeleted,
      refreshUserList: refreshUserList,
      updateUser: updateUser,
      isUserUpdated: isUserUpdated,
      createUser: createUser,
      isUserCreated: isUserCreated,
    );
  }

  //Use cases
  final GetUsersUseCase getUsersUseCase;
  final CreateUserUseCase createUserUseCase;
  final UpdateUserUseCase updateUserUseCase;
  final DeleteUserUseCase deleteUserUseCase;

  // read-only properties
  final Stream<GenericBlocState<User>> userList;
  final Stream<GenericBlocState<bool>> isUserDeleted;
  final Stream<GenericBlocState<bool>> isUserUpdated;
  final Stream<GenericBlocState<bool>> isUserCreated;

// write-only properties
  final Sink<User> deleteUser;
  final Sink<UsersFetched> refreshUserList;
  final Sink<User> updateUser;
  final Sink<User> createUser;

  //Private constructor
  const UserBloc._({
    required this.getUsersUseCase,
    required this.createUserUseCase,
    required this.updateUserUseCase,
    required this.deleteUserUseCase,
    required this.userList,
    required this.deleteUser,
    required this.isUserDeleted,
    required this.refreshUserList,
    required this.isUserUpdated,
    required this.updateUser,
    required this.createUser,
    required this.isUserCreated,
  });

  void dispose() {
    createUser.close();
    updateUser.close();
    deleteUser.close();
    refreshUserList.close();
  }
}
