import 'package:clean_architecture_rxdart/common/network/api_result.dart';
import 'package:clean_architecture_rxdart/features/comment/data/models/comment.dart';

abstract class CommentRepository {
  Future<ApiResult<List<Comment>>> getComments(int postId);

  Future<ApiResult<bool>> createComment(Comment comment);

  Future<ApiResult<bool>> deleteComment(Comment comment);
}
