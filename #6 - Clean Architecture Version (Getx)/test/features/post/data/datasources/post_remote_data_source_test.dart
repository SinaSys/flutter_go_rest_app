import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'post_remote_data_source_test.mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../test_utils/data/test_data.dart';
import 'package:clean_architecture_getx/common/network/api_config.dart';
import 'package:clean_architecture_getx/common/network/dio_client.dart';
import 'package:clean_architecture_getx/features/post/data/models/post.dart';
import 'package:clean_architecture_getx/features/post/data/datasources/post_remote_data_source.dart';

@GenerateMocks([DioClient])
void main() {
  late PostRemoteDataSourceImpl postRemoteDataSourceImpl;
  late MockDioClient mockDioClient;

  setUp(
    () {
      mockDioClient = MockDioClient();
      postRemoteDataSourceImpl = PostRemoteDataSourceImpl(dioClient: mockDioClient);
    },
  );

  group(
    'All test cases related to the createPost',
    () {
      test(
        'should return true when the response code is 200',
        () async {
          when(mockDioClient.post<Post>(ApiConfig.posts, data: tPostDummyObject)).thenAnswer(
            (_) async => Response<Post>(
              statusCode: 200,
              requestOptions: RequestOptions(),
              data: tPostDummyObject,
            ),
          );

          bool result = await postRemoteDataSourceImpl.createPost(tPostDummyObject);

          expect(result, true);
        },
      );

      test(
        'should throw a DioException when there is a failure with API call',
        () async {
          bool result = false;

          try {
            when(mockDioClient.post<Post>(ApiConfig.todos, data: tPostDummyObject)).thenThrow(
              (_) async => DioException(
                requestOptions: RequestOptions(),
                type: DioExceptionType.connectionError,
              ),
            );

            result = await postRemoteDataSourceImpl.createPost(tPostDummyObject);
          } catch (_) {
            expect(result, false);
          }
        },
      );
    },
  );

  group(
    'All test cases related to the deletePost',
    () {
      test(
        'should return true when the response code is 200',
        () async {
          when(mockDioClient.delete<Post>(tPostDummyUrl)).thenAnswer(
            (_) async => Response<Post>(
              statusCode: 200,
              requestOptions: RequestOptions(),
              data: tPostDummyObject,
            ),
          );

          bool result = await postRemoteDataSourceImpl.deletePost(tPostDummyObject);

          expect(result, true);
        },
      );

      test(
        'should throw a DioException when there is a failure with API call',
        () async {
          bool result = false;

          try {
            when(mockDioClient.delete<Post>(tPostDummyUrl, data: tPostDummyObject)).thenThrow(
              (_) async => DioException(
                requestOptions: RequestOptions(),
                type: DioExceptionType.connectionError,
              ),
            );

            result = await postRemoteDataSourceImpl.deletePost(tPostDummyObject);
          } catch (_) {
            expect(result, false);
          }
        },
      );
    },
  );

  group(
    'All test cases related to the updatePost',
    () {
      test(
        'should return true when the response code is 200',
        () async {
          when(mockDioClient.put<Post>(tPostDummyUrl, data: tPostDummyObject)).thenAnswer(
            (_) async => Response<Post>(
              statusCode: 200,
              requestOptions: RequestOptions(),
              data: tPostDummyObject,
            ),
          );

          bool result = await postRemoteDataSourceImpl.updatePost(tPostDummyObject);

          expect(result, true);
        },
      );

      test(
        'should throw a DioException when there is a failure with API call',
        () async {
          bool result = false;

          try {
            when(mockDioClient.put<Post>(tPostDummyUrl, data: tPostDummyObject)).thenThrow(
              (_) async => DioException(
                requestOptions: RequestOptions(),
                type: DioExceptionType.connectionError,
              ),
            );

            result = await postRemoteDataSourceImpl.updatePost(tPostDummyObject);
          } catch (_) {
            expect(result, false);
          }
        },
      );
    },
  );

  group(
    'All test cases related to the getPost ',
    () {
      test(
        'should return list of posts when the response code is 200',
        () async {
          when(
            mockDioClient.get(ApiConfig.posts, queryParameters: <String, String>{'user_id': "$tDummyId"}),
          ).thenAnswer(
            (_) async {
              return Response<List<Post>>(
                requestOptions: RequestOptions(),
                statusCode: 200,
                data: [tPostDummyObject],
              );
            },
          );

          List<Post> todos = await postRemoteDataSourceImpl.getUsers(tUserDummyObject);

          expect(todos, [tPostDummyObject]);
        },
      );

      test(
        'should throw a DioException when there is a failure with API call',
        () async {
          List<Post> posts = [];

          try {
            when(mockDioClient.get<Post>(ApiConfig.users, queryParameters: <String, String>{})).thenThrow(
              (_) async => DioException(
                requestOptions: RequestOptions(),
                type: DioExceptionType.connectionError,
              ),
            );

            posts = await postRemoteDataSourceImpl.getUsers(tUserDummyObject);
          } catch (_) {
            expect(posts, isEmpty);
          }
        },
      );
    },
  );
}
