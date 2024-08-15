import 'package:layered_architecture_bloc/features/comment/data/model/comment.dart';
import 'package:layered_architecture_bloc/common/network/api_base.dart';
import 'package:layered_architecture_bloc/common/network/api_result.dart';
import 'package:layered_architecture_bloc/core/api_config.dart';

class CommentApi extends ApiBase {
  Future<ApiResult<bool>> createComment(Comment comment) async {
    return await createItem(dioClient.dio!.post(ApiConfig.comments, data: comment));
  }

  Future<ApiResult<bool>> deleteComment(Comment comment) async {
    return await deleteItem(dioClient.dio!.delete("${ApiConfig.comments}/${comment.id}"));
  }

  Future<ApiResult<List<Comment>>> getUserComments(int postId) async {
    final queryParameters = {'post_id': "$postId"};

    Future<ApiResult<List<Comment>>> result = getItems(
        dioClient.dio!
            .get(ApiConfig.comments, queryParameters: queryParameters),
        Comment.fromJson);

    return result;
  }
}
