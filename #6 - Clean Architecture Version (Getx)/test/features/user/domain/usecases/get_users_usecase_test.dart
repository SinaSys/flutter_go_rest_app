import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'create_user_usecase_test.mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../test_utils/data/test_data.dart';
import 'package:clean_architecture_getx/features/user/data/models/user.dart';
import 'package:clean_architecture_getx/features/user/domain/usecases/get_users_usecase.dart';

void main() {
  late GetUsersUseCase getUsersUseCase;
  late MockUserRepository mockUserRepository;

  setUp(
    () {
      mockUserRepository = MockUserRepository();
      getUsersUseCase = GetUsersUseCase(mockUserRepository);
    },
  );

  test(
    'Should call getUsers from user repository',
    () async {
      when(mockUserRepository.getUsers()).thenAnswer(
        (_) async => const Right<String, List<User>>([tUserDummyObject]),
      );

      final result = await getUsersUseCase.call(
        const GetUsersParams(),
      );

      result.fold(
        (_) {},
        (List<User> users) => expect(users, [tUserDummyObject]),
      );

      verify(mockUserRepository.getUsers());

      verifyNoMoreInteractions(mockUserRepository);
    },
  );
}
