import 'package:layered_architecture_cubit/features/comment/data/model/comment.dart';
import 'package:layered_architecture_cubit/common/network/api_base.dart';
import 'package:layered_architecture_cubit/common/network/api_result.dart';
import 'package:layered_architecture_cubit/core/api_config.dart';

class CommentApi extends ApiBase {
  Future<ApiResult<bool>> createComment(Comment comment) async {
    return await makePostRequest(dioClient.dio!.post(ApiConfig.comments, data: comment));
  }

  Future<ApiResult<bool>> deleteComment(Comment comment) async {
    return await makeDeleteRequest(dioClient.dio!.delete("${ApiConfig.comments}/${comment.id}"));
  }

  Future<ApiResult<List<Comment>>> getUserComments(int postId) async {
    final queryParameters = {'post_id': "$postId"};

    Future<ApiResult<List<Comment>>> result = makeGetRequest(
        dioClient.dio!
            .get(ApiConfig.comments, queryParameters: queryParameters),
        Comment.fromJson);

    return result;
  }
}
