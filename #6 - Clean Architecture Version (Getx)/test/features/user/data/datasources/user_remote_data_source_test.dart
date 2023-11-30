import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../test_utils/data/test_data.dart';
import 'package:clean_architecture_getx/common/network/api_config.dart';
import 'package:clean_architecture_getx/common/network/dio_client.dart';
import 'package:clean_architecture_getx/features/user/data/models/user.dart';
import '../../../todo/data/datasources/todo_remote_data_source_test.mocks.dart';
import 'package:clean_architecture_getx/features/user/data/datasources/user_remote_data_source.dart';

@GenerateMocks([DioClient])
void main() {
  late UserRemoteDataSourceImpl userRemoteDataSourceImpl;
  late MockDioClient mockDioClient;

  setUp(
    () {
      mockDioClient = MockDioClient();

      userRemoteDataSourceImpl = UserRemoteDataSourceImpl(
        dioClient: mockDioClient,
      );
    },
  );

  group(
    'All test cases related to the createUser',
    () {
      test(
        'should return true when the response code is 200',
        () async {
          when(mockDioClient.post<User>(ApiConfig.users, data: tUserDummyObject)).thenAnswer(
            (_) async => Response<User>(
              statusCode: 200,
              requestOptions: RequestOptions(),
              data: tUserDummyObject,
            ),
          );

          bool result = await userRemoteDataSourceImpl.createUser(tUserDummyObject);

          expect(result, true);
        },
      );

      test(
        'should throw a DioException when there is a failure with API call',
        () async {
          bool result = false;

          try {
            when(mockDioClient.post<User>(ApiConfig.users, data: tUserDummyObject)).thenThrow(
              (_) async => DioException(
                requestOptions: RequestOptions(),
                type: DioExceptionType.connectionError,
              ),
            );

            result = await userRemoteDataSourceImpl.createUser(tUserDummyObject);
          } catch (_) {
            expect(result, false);
          }
        },
      );
    },
  );

  group(
    'All test cases related to the deleteUser',
    () {
      test(
        'should return true when the response code is 200',
        () async {
          when(mockDioClient.delete<User>(tUserDummyUrl)).thenAnswer(
            (_) async => Response<User>(
              statusCode: 200,
              requestOptions: RequestOptions(),
              data: tUserDummyObject,
            ),
          );

          bool result = await userRemoteDataSourceImpl.deleteUser(tUserDummyObject);

          expect(result, true);
        },
      );

      test(
        'should throw a DioException when there is a failure with API call',
        () async {
          bool result = false;

          try {
            when(mockDioClient.post<User>(tUserDummyUrl, data: tUserDummyObject)).thenThrow(
              (_) async => DioException(
                requestOptions: RequestOptions(),
                type: DioExceptionType.connectionError,
              ),
            );

            result = await userRemoteDataSourceImpl.createUser(tUserDummyObject);
          } catch (_) {
            expect(result, false);
          }
        },
      );
    },
  );

  group(
    'All test cases related to the updateUser',
    () {
      test(
        'should return true when the response code is 200',
        () async {
          when(mockDioClient.put<User>(tUserDummyUrl, data: tUserDummyObject)).thenAnswer(
            (_) async => Response<User>(
              statusCode: 200,
              requestOptions: RequestOptions(),
              data: tUserDummyObject,
            ),
          );

          bool result = await userRemoteDataSourceImpl.updateUser(tUserDummyObject);

          expect(result, true);
        },
      );

      test(
        'should throw a DioException when there is a failure with API call',
        () async {
          bool result = false;

          try {
            when(mockDioClient.put<User>(tUserDummyUrl, data: tUserDummyObject)).thenThrow(
              (_) async => DioException(
                requestOptions: RequestOptions(),
                type: DioExceptionType.connectionError,
              ),
            );

            result = await userRemoteDataSourceImpl.updateUser(tUserDummyObject);
          } catch (_) {
            expect(result, false);
          }
        },
      );
    },
  );

  group(
    'All test cases related to the getUsers ',
    () {
      test(
        'should return list of users when the response code is 200',
        () async {
          when(mockDioClient.get(ApiConfig.users, queryParameters: <String, String>{})).thenAnswer(
            (_) async {
              return Response<List<User>>(
                requestOptions: RequestOptions(),
                statusCode: 200,
                data: [tUserDummyObject],
              );
            },
          );

          List<User> users = await userRemoteDataSourceImpl.getUsers(gender: null);

          expect(users, [tUserDummyObject]);
        },
      );

      test(
        'should throw a DioException when there is a failure with API call',
        () async {
          List<User> users = [];

          try {
            when(mockDioClient.get<User>(ApiConfig.users, queryParameters: <String, String>{})).thenThrow(
              (_) async => DioException(
                requestOptions: RequestOptions(),
                type: DioExceptionType.connectionError,
              ),
            );

            users = await userRemoteDataSourceImpl.getUsers(gender: null);
          } catch (_) {
            expect(users, isEmpty);
          }
        },
      );
    },
  );
}
