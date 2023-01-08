import '../../../../common/network/api_result.dart';
import '../../data/models/comment.dart';

abstract class CommentRepository {
  Future<ApiResult<List<Comment>>> getComments(int postId);

  Future<ApiResult<bool>> createComment(Comment comment);

  Future<ApiResult<bool>> deleteComment(Comment comment);
}
