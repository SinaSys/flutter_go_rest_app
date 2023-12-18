import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'user_remote_data_source_test.mocks.dart';
import '../../../../test_utils/data/test_data.dart';
import 'package:clean_architecture_getx/common/network/api_config.dart';
import 'package:clean_architecture_getx/common/network/dio_client.dart';
import 'package:clean_architecture_getx/features/user/data/models/user.dart';
import 'package:clean_architecture_getx/features/user/domain/entities/user_entity.dart';
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

      test(
        'Should return list of users contain male gender, if query parameter with male value is added',
        () async {
          Map<String, String> queryParameters = <String, String>{};

          queryParameters.addAll({'gender': Gender.male.name});

          when(mockDioClient.get(ApiConfig.users, queryParameters: queryParameters)).thenAnswer(
            (_) async {
              return Response<List<User>>(
                requestOptions: RequestOptions(),
                statusCode: 200,
                data: [tUserDummyObject],
              );
            },
          );

          List<User> users = await userRemoteDataSourceImpl.getUsers(gender: Gender.male);

          expect(users, [tUserDummyObject]);
        },
      );

      test(
        'Should return list of users contain female gender, if query parameter with female value is added',
        () async {
          Map<String, String> queryParameters = <String, String>{};

          queryParameters.addAll({'gender': Gender.female.name});

          User userObjectContainFemale = tUserDummyObject.copyWith(gender: Gender.female);

          when(mockDioClient.get(ApiConfig.users, queryParameters: queryParameters)).thenAnswer(
            (_) async {
              return Response<List<User>>(
                requestOptions: RequestOptions(),
                statusCode: 200,
                data: [userObjectContainFemale],
              );
            },
          );

          List<User> users = await userRemoteDataSourceImpl.getUsers(gender: Gender.female);

          expect(users, [userObjectContainFemale]);
        },
      );

      test(
        'Should return list of inactive users, if query parameter with inactive value is added',
        () async {
          Map<String, String> queryParameters = <String, String>{};

          queryParameters.addAll({'status': UserStatus.inactive.name});

          when(mockDioClient.get(ApiConfig.users, queryParameters: queryParameters)).thenAnswer(
            (_) async {
              return Response<List<User>>(
                requestOptions: RequestOptions(),
                statusCode: 200,
                data: [tUserDummyObject],
              );
            },
          );

          List<User> users = await userRemoteDataSourceImpl.getUsers(status: UserStatus.inactive);

          expect(users, [tUserDummyObject]);
        },
      );

      test(
        'Should return list of active users, if query parameter with active value is added',
        () async {
          Map<String, String> queryParameters = <String, String>{};

          queryParameters.addAll({'status': UserStatus.active.name});

          User userObjectContainActiveUsers = tUserDummyObject.copyWith(status: UserStatus.active);

          when(mockDioClient.get(ApiConfig.users, queryParameters: queryParameters)).thenAnswer(
            (_) async {
              return Response<List<User>>(
                requestOptions: RequestOptions(),
                statusCode: 200,
                data: [userObjectContainActiveUsers],
              );
            },
          );

          List<User> users = await userRemoteDataSourceImpl.getUsers(status: UserStatus.active);

          expect(users, [userObjectContainActiveUsers]);
        },
      );

      test(
        'Should return list of inactive male users, if query parameter with male and inactive value is added',
        () async {
          Map<String, String> queryParameters = <String, String>{};

          queryParameters.addAll({'status': UserStatus.inactive.name});
          queryParameters.addAll({'gender': Gender.male.name});

          when(mockDioClient.get(ApiConfig.users, queryParameters: queryParameters)).thenAnswer(
            (_) async {
              return Response<List<User>>(
                requestOptions: RequestOptions(),
                statusCode: 200,
                data: [tUserDummyObject],
              );
            },
          );

          List<User> users = await userRemoteDataSourceImpl.getUsers(status: UserStatus.inactive, gender: Gender.male);

          expect(users, [tUserDummyObject]);
        },
      );
    },
  );
}
