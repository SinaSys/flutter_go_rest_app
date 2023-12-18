import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'todo_remote_data_source_test.mocks.dart';
import '../../../../test_utils/data/test_data.dart';
import 'package:clean_architecture_getx/common/network/api_config.dart';
import 'package:clean_architecture_getx/common/network/dio_client.dart';
import 'package:clean_architecture_getx/features/todo/data/models/todo.dart';
import 'package:clean_architecture_getx/features/todo/domain/entities/todo_entity.dart';
import 'package:clean_architecture_getx/features/todo/data/datasources/todo_remote_data_source.dart';

@GenerateMocks([DioClient])
void main() {
  late TodoRemoteDataSourceImpl todoRemoteDataSourceImpl;
  late MockDioClient mockDioClient;

  setUp(
    () {
      mockDioClient = MockDioClient();
      todoRemoteDataSourceImpl = TodoRemoteDataSourceImpl(dioClient: mockDioClient);
    },
  );

  group(
    'All test cases related to the createTodo',
    () {
      test(
        'should return true when the response code is 200',
        () async {
          when(mockDioClient.post<ToDo>(ApiConfig.todos, data: tTodoDummyObject)).thenAnswer(
            (_) async => Response<ToDo>(
              statusCode: 200,
              requestOptions: RequestOptions(),
              data: tTodoDummyObject,
            ),
          );

          bool result = await todoRemoteDataSourceImpl.createTodo(tTodoDummyObject);

          expect(result, true);
        },
      );

      test(
        'should throw a DioException when there is a failure with API call',
        () async {
          bool result = false;

          try {
            when(mockDioClient.post<ToDo>(ApiConfig.todos, data: tTodoDummyObject)).thenThrow(
              (_) async => DioException(
                requestOptions: RequestOptions(),
                type: DioExceptionType.connectionError,
              ),
            );

            result = await todoRemoteDataSourceImpl.createTodo(tTodoDummyObject);
          } catch (_) {
            expect(result, false);
          }
        },
      );
    },
  );

  group(
    'All test cases related to the deleteTodo',
    () {
      test(
        'should return true when the response code is 200',
        () async {
          when(mockDioClient.delete<ToDo>(tTodoDummyUrl)).thenAnswer(
            (_) async => Response<ToDo>(
              statusCode: 200,
              requestOptions: RequestOptions(),
              data: tTodoDummyObject,
            ),
          );

          bool result = await todoRemoteDataSourceImpl.deleteTodo(tTodoDummyObject);

          expect(result, true);
        },
      );

      test(
        'should throw a DioException when there is a failure with API call',
        () async {
          bool result = false;

          try {
            when(mockDioClient.post<ToDo>(tTodoDummyUrl, data: tTodoDummyObject)).thenThrow(
              (_) async => DioException(
                requestOptions: RequestOptions(),
                type: DioExceptionType.connectionError,
              ),
            );

            result = await todoRemoteDataSourceImpl.createTodo(tTodoDummyObject);
          } catch (_) {
            expect(result, false);
          }
        },
      );
    },
  );

  group(
    'All test cases related to the updateTodo',
    () {
      test(
        'should return true when the response code is 200',
        () async {
          when(mockDioClient.put<ToDo>(tTodoDummyUrl, data: tTodoDummyObject)).thenAnswer(
            (_) async => Response<ToDo>(
              statusCode: 200,
              requestOptions: RequestOptions(),
              data: tTodoDummyObject,
            ),
          );

          bool result = await todoRemoteDataSourceImpl.updateTodo(tTodoDummyObject);

          expect(result, true);
        },
      );

      test(
        'should throw a DioException when there is a failure with API call',
        () async {
          bool result = false;

          try {
            when(mockDioClient.put<ToDo>(tTodoDummyUrl, data: tTodoDummyObject)).thenThrow(
              (_) async => DioException(
                requestOptions: RequestOptions(),
                type: DioExceptionType.connectionError,
              ),
            );

            result = await todoRemoteDataSourceImpl.updateTodo(tTodoDummyObject);
          } catch (_) {
            expect(result, false);
          }
        },
      );
    },
  );

  group(
    'All test cases related to the getTodos ',
    () {
      test(
        'should return list of todos when the response code is 200',
        () async {
          when(
            mockDioClient.get(ApiConfig.todos, queryParameters: <String, String>{'user_id': "$tDummyId"}),
          ).thenAnswer(
            (_) async {
              return Response<List<ToDo>>(
                requestOptions: RequestOptions(),
                statusCode: 200,
                data: [tTodoDummyObject],
              );
            },
          );

          List<ToDo> todos = await todoRemoteDataSourceImpl.getTodos(tDummyId);

          expect(todos, [tTodoDummyObject]);
        },
      );

      test(
        'should throw a DioException when there is a failure with API call',
        () async {
          List<ToDo> todos = [];

          try {
            when(mockDioClient.get<ToDo>(ApiConfig.users, queryParameters: <String, String>{})).thenThrow(
              (_) async => DioException(
                requestOptions: RequestOptions(),
                type: DioExceptionType.connectionError,
              ),
            );

            todos = await todoRemoteDataSourceImpl.getTodos(tDummyId);
          } catch (_) {
            expect(todos, isEmpty);
          }
        },
      );

      test(
        'should return list of pending todos, if query parameter with pending value is added',
        () async {
          Map<String, String> queryParameters = <String, String>{'user_id': "$tDummyId"};

          queryParameters.addAll({'status': TodoStatus.pending.name});

          when(
            mockDioClient.get(
              ApiConfig.todos,
              queryParameters: queryParameters,
            ),
          ).thenAnswer(
            (_) async {
              return Response<List<ToDo>>(
                requestOptions: RequestOptions(),
                statusCode: 200,
                data: [tTodoDummyObject],
              );
            },
          );

          List<ToDo> todos = await todoRemoteDataSourceImpl.getTodos(tDummyId, status: TodoStatus.pending);

          expect(todos, [tTodoDummyObject]);
        },
      );

      test(
        'should return list of complete todos, if query parameter with complete value is added',
        () async {
          Map<String, String> queryParameters = <String, String>{'user_id': "$tDummyId"};

          queryParameters.addAll({'status': TodoStatus.completed.name});

          ToDo todoObjectWithCompleteTodos = tTodoDummyObject.copyWith(status: TodoStatus.completed);

          when(
            mockDioClient.get(
              ApiConfig.todos,
              queryParameters: queryParameters,
            ),
          ).thenAnswer(
            (_) async {
              return Response<List<ToDo>>(
                requestOptions: RequestOptions(),
                statusCode: 200,
                data: [todoObjectWithCompleteTodos],
              );
            },
          );

          List<ToDo> todos = await todoRemoteDataSourceImpl.getTodos(tDummyId, status: TodoStatus.completed);

          expect(todos, [todoObjectWithCompleteTodos]);
        },
      );
    },
  );
}
