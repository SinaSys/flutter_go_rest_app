import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'post_repository_impl_test.mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../test_utils/data/test_data.dart';
import 'package:clean_architecture_getx/core/app_string.dart';
import 'package:clean_architecture_getx/common/network/dio_exception.dart';
import 'package:clean_architecture_getx/features/post/data/models/post.dart';
import 'package:clean_architecture_getx/features/post/data/repositories/post_repository_impl.dart';
import 'package:clean_architecture_getx/features/post/data/datasources/post_remote_data_source.dart';

@GenerateMocks([PostRemoteDataSource])
void main() {
  late PostRepositoryImpl postRepositoryImpl;
  late MockPostRemoteDataSource mockPostRemoteDataSource;

  setUp(
    () {
      mockPostRemoteDataSource = MockPostRemoteDataSource();
      postRepositoryImpl = PostRepositoryImpl(remoteDataSource: mockPostRemoteDataSource);
    },
  );

  group(
    'All test cases related to the createPost',
    () {
      test(
        'Should return true if createPost is called from post repository successfully',
        () async {
          when(mockPostRemoteDataSource.createPost(tPostDummyObject)).thenAnswer((_) async => true);

          final Either<String, bool> result = await postRepositoryImpl.createPost(tPostDummyObject);

          verify(mockPostRemoteDataSource.createPost(tPostDummyObject));

          expect(result, const Right(true));
        },
      );

      test(
        'Should return DioException if calling createPost from post repository causes exception',
        () async {
          try {
            when(mockPostRemoteDataSource.createPost(tPostDummyObject)).thenThrow(
              DioExceptions.fromDioError(
                DioException(
                  type: DioExceptionType.connectionTimeout,
                  requestOptions: RequestOptions(),
                ),
              ),
            );

            await postRepositoryImpl.createPost(tPostDummyObject);
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
    'All test cases related to the updatePost',
    () {
      test(
        'Should return true if updatePost is called from post repository successfully',
        () async {
          when(mockPostRemoteDataSource.updatePost(tPostDummyObject)).thenAnswer((_) async => true);

          final Either<String, bool> result = await postRepositoryImpl.updatePost(tPostDummyObject);

          verify(mockPostRemoteDataSource.updatePost(tPostDummyObject));

          expect(result, const Right(true));
        },
      );

      test(
        'Should return DioException if calling updatePost from post repository causes exception',
        () async {
          try {
            when(mockPostRemoteDataSource.updatePost(tPostDummyObject)).thenThrow(
              DioExceptions.fromDioError(
                DioException(
                  type: DioExceptionType.connectionTimeout,
                  requestOptions: RequestOptions(),
                ),
              ),
            );

            await postRepositoryImpl.updatePost(tPostDummyObject);
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
    'All test cases related to the deletePost',
    () {
      test(
        'Should return true if deletePost is called from post repository successfully',
        () async {
          when(mockPostRemoteDataSource.deletePost(tPostDummyObject)).thenAnswer((_) async => true);

          final Either<String, bool> result = await postRepositoryImpl.deletePost(tPostDummyObject);

          verify(mockPostRemoteDataSource.deletePost(tPostDummyObject));

          expect(result, const Right(true));
        },
      );

      test(
        'Should return DioException if calling deletePost from post repository causes exception',
        () async {
          try {
            when(mockPostRemoteDataSource.deletePost(tPostDummyObject)).thenThrow(
              DioExceptions.fromDioError(
                DioException(
                  type: DioExceptionType.connectionTimeout,
                  requestOptions: RequestOptions(),
                ),
              ),
            );

            await postRepositoryImpl.deletePost(tPostDummyObject);
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
    'All test cases related to the getPosts',
    () {
      test(
        'Should return list of posts if getUsers is called from post repository successfully',
        () async {
          when(mockPostRemoteDataSource.getUsers(tUserDummyObject)).thenAnswer((_) async => <Post>[]);

          final Either<String, List<Post>> result = await postRepositoryImpl.getPosts(tUserDummyObject);

          verify(mockPostRemoteDataSource.getUsers(tUserDummyObject));

          expect(result, isA<Right<String, List<Post>>>());
          expect(result.isRight(), true);
        },
      );

      test(
        'Should return DioException if calling getUsers from post repository causes exception',
        () async {
          try {
            when(mockPostRemoteDataSource.getUsers(tUserDummyObject)).thenThrow(
              DioExceptions.fromDioError(
                DioException(
                  type: DioExceptionType.connectionTimeout,
                  requestOptions: RequestOptions(),
                ),
              ),
            );

            await postRepositoryImpl.getPosts(tUserDummyObject);
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
