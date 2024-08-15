import 'package:clean_architecture_getx/common/network/api_base.dart';
import 'package:clean_architecture_getx/common/network/api_config.dart';
import 'package:clean_architecture_getx/common/network/dio_client.dart';
import 'package:clean_architecture_getx/features/comment/data/models/comment.dart';

abstract class CommentRemoteDataSource {
  Future<List<Comment>> getComments(int postId);

  Future<bool> createComment(Comment comment);

  Future<bool> deleteComment(Comment comment);
}

class CommentRemoteDataSourceImpl with ApiBase implements CommentRemoteDataSource {
  final DioClient dioClient;

  const CommentRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<bool> createComment(Comment comment) async {
    return await makePostRequest(
      dioClient.post(ApiConfig.comments, data: comment),
    );
  }

  @override
  Future<bool> deleteComment(Comment comment) async {
    return await makeDeleteRequest(
      dioClient.delete("${ApiConfig.comments}/${comment.id}"),
    );
  }

  @override
  Future<List<Comment>> getComments(int postId) async {
    final queryParameters = {'post_id': "$postId"};

    return await makeGetRequest(
      dioClient.get(ApiConfig.comments, queryParameters: queryParameters),
      Comment.fromJson,
    );
  }
}
