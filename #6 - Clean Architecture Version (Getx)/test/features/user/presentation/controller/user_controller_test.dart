import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'user_controller_test.mocks.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../test_utils/data/test_data.dart';
import 'package:clean_architecture_getx/features/user/data/models/user.dart';
import 'package:clean_architecture_getx/common/controller/base_controller.dart';
import 'package:clean_architecture_getx/features/user/domain/usecases/get_users_usecase.dart';
import 'package:clean_architecture_getx/features/user/domain/usecases/update_user_usecase.dart';
import 'package:clean_architecture_getx/features/user/domain/usecases/create_user_usecase.dart';
import 'package:clean_architecture_getx/features/user/domain/usecases/delete_user_usecase.dart';
import 'package:clean_architecture_getx/features/user/presentation/controller/user_controller.dart';

@GenerateMocks([
  GetUsersUseCase,
  CreateUserUseCase,
  UpdateUserUseCase,
  DeleteUserUseCase,
])
void main() {
  late MockGetUsersUseCase mockGetUsersUseCase;
  late MockCreateUserUseCase mockCreateUserUseCase;
  late MockUpdateUserUseCase mockUpdateUserUseCase;
  late MockDeleteUserUseCase mockDeleteUserUseCase;
  late UserController userController;

  setUp(
    () {
      mockGetUsersUseCase = MockGetUsersUseCase();
      mockDeleteUserUseCase = MockDeleteUserUseCase();
      mockUpdateUserUseCase = MockUpdateUserUseCase();
      mockCreateUserUseCase = MockCreateUserUseCase();

      userController = UserController(
        getUsersUseCase: mockGetUsersUseCase,
        createUserUseCase: mockCreateUserUseCase,
        updateUserUseCase: mockUpdateUserUseCase,
        deleteUserUseCase: mockDeleteUserUseCase,
      );
    },
  );

  group(
    'All test cases related to the CreateUser ',
    () {
      test(
        'should emit [success] when data is gotten successfully',
        () async {
          expect(userController.apiStatus.value, ApiState.loading);

          when(mockCreateUserUseCase.call(any)).thenAnswer(
            (_) async => const Right(true),
          );

          await userController.createUser(tUserDummyObject);

          expect(userController.apiStatus.value, ApiState.success);
        },
      );

      test(
        'should emit [failure] when data is not gotten successfully',
        () async {
          expect(userController.apiStatus.value, ApiState.loading);

          when(mockCreateUserUseCase.call(any)).thenAnswer(
            (_) async => const Left(tDummyExceptionMsg),
          );

          await userController.createUser(tUserDummyObject);

          expect(userController.apiStatus.value, ApiState.failure);

          expect(userController.errorMessage.value, tDummyExceptionMsg);
        },
      );
    },
  );

  group(
    'All test cases related to the updateUser',
    () {
      test(
        'should emit [success] when data is gotten successfully',
        () async {
          expect(userController.apiStatus.value, ApiState.loading);

          when(mockUpdateUserUseCase.call(any)).thenAnswer((_) async => const Right(true));

          await userController.updateUser(tUserDummyObject);

          expect(userController.apiStatus.value, ApiState.success);
        },
      );

      test(
        'should emit [failure] when data is not gotten successfully',
        () async {
          expect(userController.apiStatus.value, ApiState.loading);

          when(mockUpdateUserUseCase.call(any)).thenAnswer((_) async => const Left(tDummyExceptionMsg));

          await userController.updateUser(tUserDummyObject);

          expect(userController.apiStatus.value, ApiState.failure);

          expect(userController.errorMessage.value, tDummyExceptionMsg);
        },
      );
    },
  );

  group(
    'All test cases related to the deleteUser',
    () {
      test(
        'should emit [success] when data is gotten successfully',
        () async {
          expect(userController.apiStatus.value, ApiState.loading);

          when(mockDeleteUserUseCase.call(any)).thenAnswer((_) async => const Right(true));

          await userController.deleteUser(tUserDummyObject);

          expect(userController.apiStatus.value, ApiState.success);
        },
      );

      test(
        'should emit [failure] when data is not gotten successfully',
        () async {
          expect(userController.apiStatus.value, ApiState.loading);

          when(mockDeleteUserUseCase.call(any)).thenAnswer((_) async => const Left(tDummyExceptionMsg));

          await userController.deleteUser(tUserDummyObject);

          expect(userController.apiStatus.value, ApiState.failure);

          expect(userController.errorMessage.value, tDummyExceptionMsg);
        },
      );
    },
  );

  group(
    'All test cases related to the getUserList',
    () {
      test(
        'should get list of users when data is gotten successfully',
        () async {
          when(mockGetUsersUseCase.call(any)).thenAnswer((_) async => const Right([tUserDummyObject]));

          await userController.getUserList();

          userController.failureOrSuccess?.fold(
            (_) {},
            (List<User> users) => expect(users, [tUserDummyObject]),
          );
        },
      );

      test(
        'should get error message when data is not gotten successfully',
        () async {
          when(mockGetUsersUseCase.call(any)).thenAnswer((_) async => const Left(tDummyExceptionMsg));

          await userController.getUserList();

          userController.failureOrSuccess?.fold(
            (String error) => expect(error, tDummyExceptionMsg),
            (_) {},
          );
        },
      );
    },
  );
}
