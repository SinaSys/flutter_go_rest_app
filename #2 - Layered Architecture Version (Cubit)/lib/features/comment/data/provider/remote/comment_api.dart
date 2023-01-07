import '../../../../../common/network/api_base.dart';
import '../../../../../common/network/api_result.dart';
import '../../../../../core/api_config.dart';
import '../../model/comment.dart';

class CommentApi extends ApiBase<Comment> {
  Future<ApiResult<bool>> createComment(Comment comment) async {
    return await requestMethodTemplate(
      dioClient.dio!.post(ApiConfig.comments, data: comment),
    );
  }

  Future<ApiResult<bool>> deleteComment(Comment comment) async {
    return await requestMethodTemplate(
      dioClient.dio!.delete("${ApiConfig.comments}/${comment.id}"),
    );
  }

  Future<ApiResult<List<Comment>>> getUserComments(int postId) async {
    final queryParameters = {'post_id': "$postId"};

    Future<ApiResult<List<Comment>>> result = getData(
        dioClient.dio!
            .get(ApiConfig.comments, queryParameters: queryParameters),
        Comment.fromJson);

    return result;
  }
}
