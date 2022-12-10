import '../../../../common/network/api_helper.dart';

import '../../../../common/network/api_config.dart';
import '../../../../common/network/dio_client.dart';
import '../../../../di.dart';
import '../models/comment.dart';

abstract class CommentRemoteDataSource {
  Future<List<Comment>> getComments(int postId);

  Future<bool> createComment(Comment comment);

  Future<bool> deleteComment(Comment comment);
}

class CommentRemoteDataSourceImpl with ApiHelper<Comment> implements CommentRemoteDataSource {
  final DioClient dioClient = getIt<DioClient>();

  @override
  Future<bool> createComment(Comment comment) async {
    return await makePostRequest(dioClient.dio.post(ApiConfig.comments, data: comment));
  }

  @override
  Future<bool> deleteComment(Comment comment) async {
    return await makeDeleteRequest(dioClient.dio.delete("${ApiConfig.comments}/${comment.id}"));
  }

  @override
  Future<List<Comment>> getComments(int postId) async {
    final queryParameters = {'post_id': "$postId"};

    return await makeGetRequest(
        dioClient.dio.get(ApiConfig.comments, queryParameters: queryParameters),
        Comment.fromJson);
  }
}
