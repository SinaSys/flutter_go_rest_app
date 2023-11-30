import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'todo_repository_impl_test.mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../test_utils/data/test_data.dart';
import 'package:clean_architecture_getx/core/app_string.dart';
import 'package:clean_architecture_getx/common/network/dio_exception.dart';
import 'package:clean_architecture_getx/features/todo/data/models/todo.dart';
import 'package:clean_architecture_getx/features/todo/data/repositories/todo_repository_impl.dart';
import 'package:clean_architecture_getx/features/todo/data/datasources/todo_remote_data_source.dart';

@GenerateMocks([TodoRemoteDataSource])
void main() {
  late TodoRepositoryImpl todoRepositoryImpl;
  late MockTodoRemoteDataSource mockTodoRemoteDataSource;

  setUp(
    () {
      mockTodoRemoteDataSource = MockTodoRemoteDataSource();
      todoRepositoryImpl = TodoRepositoryImpl(remoteDataSource: mockTodoRemoteDataSource);
    },
  );

  group(
    'All test cases related to the getTodos',
    () {
      test(
        'Should return list of todos if getTodos is called from todo repository successfully',
        () async {
          when(mockTodoRemoteDataSource.getTodos(tUserDummyObject.id)).thenAnswer((_) async => <ToDo>[]);

          final Either<String, List<ToDo>> result = await todoRepositoryImpl.getTodos(tUserDummyObject.id!);

          verify(mockTodoRemoteDataSource.getTodos(tUserDummyObject.id));

          expect(result, isA<Right<String, List<ToDo>>>());
          expect(result.isRight(), true);
        },
      );

      test(
        'Should return DioException if calling getTodos from todo repository causes exception',
        () async {
          try {
            when(mockTodoRemoteDataSource.getTodos(tUserDummyObject.id)).thenThrow(
              DioExceptions.fromDioError(
                DioException(
                  type: DioExceptionType.connectionTimeout,
                  requestOptions: RequestOptions(),
                ),
              ),
            );

            await todoRepositoryImpl.getTodos(tUserDummyObject.id!);
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
    'All test cases related to the createTodo',
    () {
      test(
        'Should return true if createTodo is called from todo repository successfully',
        () async {
          when(mockTodoRemoteDataSource.createTodo(tTodoDummyObject)).thenAnswer(
            (_) async => true,
          );

          final Either<String, bool> result = await todoRepositoryImpl.createTodo(tTodoDummyObject);

          verify(mockTodoRemoteDataSource.createTodo(tTodoDummyObject));

          expect(result, const Right(true));
        },
      );

      test(
        'Should return DioException if calling createTodo from todo repository causes exception',
        () async {
          try {
            when(mockTodoRemoteDataSource.createTodo(tTodoDummyObject)).thenThrow(
              DioExceptions.fromDioError(
                DioException(
                  type: DioExceptionType.connectionTimeout,
                  requestOptions: RequestOptions(),
                ),
              ),
            );

            await todoRepositoryImpl.createTodo(tTodoDummyObject);
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
    'All test cases related to the updateTodo',
    () {
      test(
        'Should return true if updateTodo is called from todo repository successfully',
        () async {
          when(mockTodoRemoteDataSource.updateTodo(tTodoDummyObject)).thenAnswer(
            (_) async => true,
          );

          final Either<String, bool> result = await todoRepositoryImpl.updateTodo(tTodoDummyObject);

          verify(mockTodoRemoteDataSource.updateTodo(tTodoDummyObject));

          expect(result, const Right(true));
        },
      );

      test(
        'Should return DioException if calling updateTodo from todo repository causes exception',
        () async {
          try {
            when(mockTodoRemoteDataSource.updateTodo(tTodoDummyObject)).thenThrow(
              DioExceptions.fromDioError(
                DioException(
                  type: DioExceptionType.connectionTimeout,
                  requestOptions: RequestOptions(),
                ),
              ),
            );

            await todoRepositoryImpl.updateTodo(tTodoDummyObject);
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
    'All test cases related to the deleteTodo',
    () {
      test(
        'Should return true if deleteTodo is called from todo repository successfully',
        () async {
          when(mockTodoRemoteDataSource.deleteTodo(tTodoDummyObject)).thenAnswer(
            (_) async => true,
          );

          final Either<String, bool> result = await todoRepositoryImpl.deleteTodo(tTodoDummyObject);

          verify(mockTodoRemoteDataSource.deleteTodo(tTodoDummyObject));

          expect(result, const Right(true));
        },
      );

      test(
        'Should return DioException if calling deleteTodo from todo repository causes exception',
        () async {
          try {
            when(mockTodoRemoteDataSource.deleteTodo(tTodoDummyObject)).thenThrow(
              DioExceptions.fromDioError(
                DioException(
                  type: DioExceptionType.connectionTimeout,
                  requestOptions: RequestOptions(),
                ),
              ),
            );

            await todoRepositoryImpl.deleteTodo(tTodoDummyObject);
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
