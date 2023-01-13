import 'package:clean_architecture_riverpod/features/user/data/datasources/user_remote_data_source.dart';
import 'package:clean_architecture_riverpod/features/user/data/repositories/user_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/network/api_result.dart';
import '../../../../common/riverpod/generic_provider.dart';
import '../../../../common/riverpod/generic_state.dart';
import '../../../../di.dart';
import '../../data/models/user.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/create_user_usecase.dart';
import '../../domain/usecases/delete_user_usecase.dart';
import '../../domain/usecases/get_users_usecase.dart';
import '../../domain/usecases/update_user_usecase.dart';

final userProvider = StateNotifierProvider<UserNotifier, GenericState<User>>(
  (_) => getIt<UserNotifier>(),
);

final pp = Provider<bool>((ref) => ref.watch(pp0));

final pp0 = Provider<bool>((ref) => false);

final stateProvider = StateProvider<bool>(
  (ref) {
    var t = ref.watch(userProvider.notifier);
    print("ApiOperation is ${(t.apiOperation)}");
    if (t.apiOperation==ApiOperation.select) {
      return true;
    }
    return false;
  },
);

// final stateProvider = StateProvider<GenericState<User>?>(
//   (ref) {
//     var t = ref.watch(userProvider);
//   //  t.data.where((element) => element.status==Users)
//     if(t.httpMethod==HttpMethod.get) {
//       return ref.watch(userProvider);
//     }
//     return null;
//   },
// );

// final userProvider3 = StateNotifierProvider<UserNotifier, GenericState<User>>(
//       (ref) {
//         final t = ref.watch(userProvider);
//         t.
//       },
// );

// final userProvider2 = Provider<GenericState<User>>((ref) {
//   final state = ref.watch(userProvider);
//   if (ref.read(userProvider).httpMethod == HttpMethod.get) {
//     return state;
//   }
//   // return [];
// });

// final charactersProvider = FutureProvider<List<Character>>((ref) async {
//   final search = ref.watch(searchProvider);
//   final configs = await ref.watch(configsProvider.future);
//   final response = await dio.get('${configs.host}/characters?search=$search');
//
//   return response.data.map((json) => Character.fromJson(json)).toList();
// });

class UserNotifier extends GenericStateNotifier<User> {
  final GetUsersUseCase getUsersUseCase;
  final CreateUserUseCase createUserUseCase;
  final UpdateUserUseCase updateUserUseCase;
  final DeleteUserUseCase deleteUserUseCase;

  UserNotifier({
    required this.getUsersUseCase,
    required this.createUserUseCase,
    required this.updateUserUseCase,
    required this.deleteUserUseCase,
  });

  Future<void> getUserList({
    Gender gender = Gender.all,
    UserStatus status = UserStatus.all,
  }) async {
    getItems(
        getUsersUseCase.call(GetUsersParams(status: status, gender: gender)));
  }

  Future<void> createUser(User user) async {
    //  operation = ApiOperation.create;
    createItem(createUserUseCase.call(CreateUserParams(user)));
  }

  Future<void> updateUser(User user) async {
    //  operation = ApiOperation.update;
    updateItem(updateUserUseCase.call(UpdateUserParams(user)));
  }

  Future<void> deleteUser(User user) async {
    //operation = ApiOperation.delete;
    deleteItem(deleteUserUseCase.call(DeleteUserParams(user)));
  }
}
