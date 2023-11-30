import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../test_utils/data/test_data.dart';
import 'comment_repository_impl_test.mocks.dart';
import 'package:clean_architecture_getx/core/app_string.dart';
import 'package:clean_architecture_getx/common/network/dio_exception.dart';
import 'package:clean_architecture_getx/features/comment/data/models/comment.dart';
import 'package:clean_architecture_getx/features/comment/data/repositories/comment_repository_impl.dart';
import 'package:clean_architecture_getx/features/comment/data/datasources/comment_remote_data_source.dart';

@GenerateMocks([CommentRemoteDataSource])
void main() {
  late CommentRepositoryImpl commentRepositoryImpl;
  late MockCommentRemoteDataSource mockCommentRemoteDataSource;

  setUp(
    () {
      mockCommentRemoteDataSource = MockCommentRemoteDataSource();
      commentRepositoryImpl = CommentRepositoryImpl(remoteDataSource: mockCommentRemoteDataSource);
    },
  );

  group(
    'All test cases related to the createComment',
    () {
      test(
        'Should return true if createComment is called from comment repository successfully',
        () async {
          when(mockCommentRemoteDataSource.createComment(tCommentDummyObject)).thenAnswer((_) async => true);

          final Either<String, bool> result = await commentRepositoryImpl.createComment(tCommentDummyObject);

          verify(mockCommentRemoteDataSource.createComment(tCommentDummyObject));

          expect(result, const Right(true));
        },
      );

      test(
        'Should return DioException if calling createComment from comment repository causes exception',
        () async {
          try {
            when(mockCommentRemoteDataSource.createComment(tCommentDummyObject)).thenThrow(
              DioExceptions.fromDioError(
                DioException(
                  type: DioExceptionType.connectionTimeout,
                  requestOptions: RequestOptions(),
                ),
              ),
            );

            await commentRepositoryImpl.createComment(tCommentDummyObject);
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
    'All test cases related to the deleteComment',
    () {
      test(
        'Should return true if deleteComment is called from comment repository successfully',
        () async {
          when(mockCommentRemoteDataSource.deleteComment(tCommentDummyObject)).thenAnswer((_) async => true);

          final Either<String, bool> result = await commentRepositoryImpl.deleteComment(tCommentDummyObject);

          verify(mockCommentRemoteDataSource.deleteComment(tCommentDummyObject));

          expect(result, const Right(true));
        },
      );

      test(
        'Should return DioException if calling deleteComment from comment repository causes exception',
        () async {
          try {
            when(mockCommentRemoteDataSource.deleteComment(tCommentDummyObject)).thenThrow(
              DioExceptions.fromDioError(
                DioException(
                  type: DioExceptionType.connectionTimeout,
                  requestOptions: RequestOptions(),
                ),
              ),
            );

            await commentRepositoryImpl.deleteComment(tCommentDummyObject);
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
    'All test cases related to the getComments',
    () {
      test(
        'Should return list of comments if getComments is called from comment repository successfully',
        () async {
          when(mockCommentRemoteDataSource.getComments(tPostDummyObject.id)).thenAnswer((_) async => <Comment>[]);

          final Either<String, List<Comment>> result = await commentRepositoryImpl.getComments(tPostDummyObject.id);

          verify(mockCommentRemoteDataSource.getComments(tPostDummyObject.id));

          expect(result, isA<Right<String, List<Comment>>>());

          expect(result.isRight(), true);
        },
      );

      test(
        'Should return DioException if calling getComments from comment repository causes exception',
        () async {
          try {
            when(mockCommentRemoteDataSource.getComments(tPostDummyObject.id)).thenThrow(
              DioExceptions.fromDioError(
                DioException(
                  type: DioExceptionType.connectionTimeout,
                  requestOptions: RequestOptions(),
                ),
              ),
            );

            await commentRepositoryImpl.getComments(tPostDummyObject.id);
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
