import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'user_repository_impl_test.mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../test_utils/data/test_data.dart';
import 'package:clean_architecture_getx/core/app_string.dart';
import 'package:clean_architecture_getx/common/network/dio_exception.dart';
import 'package:clean_architecture_getx/features/user/data/models/user.dart';
import 'package:clean_architecture_getx/features/user/data/repositories/user_repository_impl.dart';
import 'package:clean_architecture_getx/features/user/data/datasources/user_remote_data_source.dart';

@GenerateMocks([UserRemoteDataSource])
void main() {
  late UserRepositoryImpl userRepositoryImpl;
  late MockUserRemoteDataSource mockUserRemoteDataSource;

  setUp(
    () {
      mockUserRemoteDataSource = MockUserRemoteDataSource();
      userRepositoryImpl = UserRepositoryImpl(
        remoteDataSource: mockUserRemoteDataSource,
      );
    },
  );

  group(
    'All test cases related to the createUser',
    () {
      test(
        'Should return true if createUser is called from user repository successfully',
        () async {
          when(mockUserRemoteDataSource.createUser(tUserDummyObject)).thenAnswer(
            (_) async => true,
          );

          final Either<String, bool> result = await userRepositoryImpl.createUser(tUserDummyObject);

          verify(mockUserRemoteDataSource.createUser(tUserDummyObject));

          expect(result, const Right(true));
        },
      );

      test(
        'Should return DioException if calling createUser from user repository causes exception',
        () async {
          try {
            when(mockUserRemoteDataSource.createUser(tUserDummyObject)).thenThrow(
              DioExceptions.fromDioError(
                DioException(
                  type: DioExceptionType.connectionTimeout,
                  requestOptions: RequestOptions(),
                ),
              ),
            );

            await userRepositoryImpl.createUser(tUserDummyObject);
          } catch (exception) {
            expect(
              exception,
              allOf(
                isA<DioExceptions>(),
                predicate<DioExceptions>(
                  (exception) => exception.message == AppString.connectionTimeOut,
                ),
              ),
            );
          }
        },
      );
    },
  );

  group(
    'All test cases related to the updateUser',
    () {
      test(
        'Should return true if updateUser is called from user repository successfully',
        () async {
          when(mockUserRemoteDataSource.updateUser(tUserDummyObject)).thenAnswer(
            (_) async => true,
          );

          final Either<String, bool> result = await userRepositoryImpl.updateUser(tUserDummyObject);

          verify(mockUserRemoteDataSource.updateUser(tUserDummyObject));

          expect(result, const Right(true));
        },
      );

      test(
        'Should return DioException if calling updateUser from user repository causes exception',
        () async {
          try {
            when(mockUserRemoteDataSource.updateUser(tUserDummyObject)).thenThrow(
              DioExceptions.fromDioError(
                DioException(
                  type: DioExceptionType.connectionTimeout,
                  requestOptions: RequestOptions(),
                ),
              ),
            );

            await userRepositoryImpl.updateUser(tUserDummyObject);
          } catch (exception) {
            expect(
              exception,
              allOf(
                isA<DioExceptions>(),
                predicate<DioExceptions>(
                  (exception) => exception.message == AppString.connectionTimeOut,
                ),
              ),
            );
          }
        },
      );
    },
  );

  group(
    'All test cases related to the deleteUser',
    () {
      test(
        'Should return true if deleteUser is called from user repository successfully',
        () async {
          when(mockUserRemoteDataSource.deleteUser(tUserDummyObject)).thenAnswer(
            (_) async => true,
          );

          final Either<String, bool> result = await userRepositoryImpl.deleteUser(tUserDummyObject);

          verify(mockUserRemoteDataSource.deleteUser(tUserDummyObject));

          expect(result, const Right(true));
        },
      );

      test(
        'Should return DioException if calling deleteUser from user repository causes exception',
        () async {
          try {
            when(mockUserRemoteDataSource.deleteUser(tUserDummyObject)).thenThrow(
              DioExceptions.fromDioError(
                DioException(
                  type: DioExceptionType.connectionTimeout,
                  requestOptions: RequestOptions(),
                ),
              ),
            );

            await userRepositoryImpl.deleteUser(tUserDummyObject);
          } catch (exception) {
            expect(
              exception,
              allOf(
                isA<DioExceptions>(),
                predicate<DioExceptions>(
                  (exception) => exception.message == AppString.connectionTimeOut,
                ),
              ),
            );
          }
        },
      );
    },
  );

  group(
    'All test cases related to the getUsers',
    () {
      test(
        'Should return list of users if getUsers is called from user repository successfully',
        () async {
          when(mockUserRemoteDataSource.getUsers()).thenAnswer(
            (_) async => [tUserDummyObject],
          );

          final result = await userRepositoryImpl.getUsers();

          verify(mockUserRemoteDataSource.getUsers());

          expect(result, isA<Right<String, List<User>>>());
          expect(result.isRight(), true);

          result.fold(
            (fail) => {},
            (success) => expect(success, [tUserDummyObject]),
          );
        },
      );

      test(
        'Should return DioException if calling getUsers from user repository causes exception',
        () async {
          try {
            when(mockUserRemoteDataSource.getUsers()).thenThrow(
              DioExceptions.fromDioError(
                DioException(
                  type: DioExceptionType.connectionTimeout,
                  requestOptions: RequestOptions(),
                ),
              ),
            );

            await userRepositoryImpl.getUsers();
          } catch (exception) {
            expect(
              exception,
              allOf(
                isA<DioExceptions>(),
                predicate<DioExceptions>(
                  (exception) => exception.message == AppString.connectionTimeOut,
                ),
              ),
            );
          }
        },
      );
    },
  );
}
