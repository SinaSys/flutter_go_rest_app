import 'package:clean_architecture_bloc/features/comment/data/models/comment.dart';

import '../../../../common/network/api_result.dart';

abstract class CommentRepository {
  Future<ApiResult<List<Comment>>> getComments(int postId);

  Future<ApiResult<bool>> createComment(Comment comment);

  Future<ApiResult<bool>> deleteComment(Comment comment);
}
