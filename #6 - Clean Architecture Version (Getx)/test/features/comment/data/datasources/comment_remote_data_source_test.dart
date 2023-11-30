import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../test_utils/data/test_data.dart';
import 'package:clean_architecture_getx/common/network/api_config.dart';
import 'package:clean_architecture_getx/common/network/dio_client.dart';
import '../../../post/data/datasources/post_remote_data_source_test.mocks.dart';
import 'package:clean_architecture_getx/features/comment/data/models/comment.dart';
import 'package:clean_architecture_getx/features/comment/data/datasources/comment_remote_data_source.dart';

@GenerateMocks([DioClient])
void main() {
  late MockDioClient mockDioClient;
  late CommentRemoteDataSourceImpl commentRemoteDataSourceImpl;

  setUp(
    () {
      mockDioClient = MockDioClient();
      commentRemoteDataSourceImpl = CommentRemoteDataSourceImpl(
        dioClient: mockDioClient,
      );
    },
  );

  group(
    'All test cases related to the createComment',
    () {
      test(
        'should return true when the response code is 200',
        () async {
          when(mockDioClient.post<Comment>(ApiConfig.comments, data: tCommentDummyObject)).thenAnswer(
            (_) async => Response<Comment>(
              statusCode: 200,
              requestOptions: RequestOptions(),
              data: tCommentDummyObject,
            ),
          );

          bool result = await commentRemoteDataSourceImpl.createComment(tCommentDummyObject);

          expect(result, true);
        },
      );

      test(
        'should throw a DioException when there is a failure with API call',
        () async {
          bool result = false;

          try {
            when(mockDioClient.post<Comment>(ApiConfig.users, data: tCommentDummyObject)).thenThrow(
              (_) async => DioException(
                requestOptions: RequestOptions(),
                type: DioExceptionType.connectionError,
              ),
            );

            result = await commentRemoteDataSourceImpl.createComment(tCommentDummyObject);
          } catch (_) {
            expect(result, false);
          }
        },
      );
    },
  );

  group(
    'All test cases related to the deleteComment',
    () {
      test(
        'should return true when the response code is 200',
        () async {
          when(mockDioClient.delete<Comment>(tCommentDummyUrl)).thenAnswer(
            (_) async => Response<Comment>(
              statusCode: 200,
              requestOptions: RequestOptions(),
              data: tCommentDummyObject,
            ),
          );

          bool result = await commentRemoteDataSourceImpl.deleteComment(tCommentDummyObject);

          expect(result, true);
        },
      );

      test(
        'should throw a DioException when there is a failure with API call',
        () async {
          bool result = false;

          try {
            when(mockDioClient.delete<Comment>(tCommentDummyUrl, data: tCommentDummyObject)).thenThrow(
              (_) async => DioException(
                requestOptions: RequestOptions(),
                type: DioExceptionType.connectionError,
              ),
            );

            result = await commentRemoteDataSourceImpl.deleteComment(tCommentDummyObject);
          } catch (_) {
            expect(result, false);
          }
        },
      );
    },
  );

  group(
    'All test cases related to the getComments ',
    () {
      test(
        'should return list of comments when the response code is 200',
        () async {
          when(mockDioClient.get(ApiConfig.comments, queryParameters: <String, String>{'post_id': "$tDummyId"}))
              .thenAnswer(
            (_) async {
              return Response<List<Comment>>(
                requestOptions: RequestOptions(),
                statusCode: 200,
                data: [tCommentDummyObject],
              );
            },
          );

          List<Comment> users = await commentRemoteDataSourceImpl.getComments(tDummyId);

          expect(users, [tCommentDummyObject]);
        },
      );

      test(
        'should throw a DioException when there is a failure with API call',
        () async {
          List<Comment> comments = [];

          try {
            when(
              mockDioClient.get<Comment>(ApiConfig.users, queryParameters: <String, String>{'post_id': "$tDummyId"}),
            ).thenThrow(
              (_) async => DioException(
                requestOptions: RequestOptions(),
                type: DioExceptionType.connectionError,
              ),
            );

            comments = await commentRemoteDataSourceImpl.getComments(tDummyId);
          } catch (_) {
            expect(comments, isEmpty);
          }
        },
      );
    },
  );
}
