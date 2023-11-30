import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'create_user_usecase_test.mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../test_utils/data/test_data.dart';
import 'package:clean_architecture_getx/features/user/domain/usecases/delete_user_usecase.dart';

void main() {
  late DeleteUserUseCase deleteUserUseCase;
  late MockUserRepository mockUserRepository;

  setUp(
    () {
      mockUserRepository = MockUserRepository();
      deleteUserUseCase = DeleteUserUseCase(mockUserRepository);
    },
  );

  test(
    'Should get deleteUser from user repository',
    () async {
      when(mockUserRepository.deleteUser(tUserDummyObject)).thenAnswer(
        (_) async => const Right<String, bool>(true),
      );

      final result = await deleteUserUseCase.call(const DeleteUserParams(tUserDummyObject));

      expect(result, const Right<String, bool>(true));

      verify(mockUserRepository.deleteUser(tUserDummyObject));

      verifyNoMoreInteractions(mockUserRepository);
    },
  );
}
