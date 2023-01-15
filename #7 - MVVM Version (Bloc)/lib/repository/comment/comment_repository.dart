import 'package:mvvm_bloc/common/repository/repository_helper.dart';
import 'package:mvvm_bloc/data/api/comment/comment_api.dart';
import 'package:mvvm_bloc/data/model/comment/comment.dart';
import 'package:mvvm_bloc/common/network/api_result.dart';

class CommentRepository with RepositoryHelper<Comment> {
  final CommentApi commentApi;

  CommentRepository({required this.commentApi});

  Future<ApiResult<bool>> createComment(Comment comment) async {
    return checkItemFailOrSuccess(commentApi.createComment(comment));
  }

  Future<ApiResult<bool>> deleteComment(Comment comment) async {
    return checkItemFailOrSuccess(commentApi.deleteComment(comment));
  }

  Future<ApiResult<List<Comment>>> getComments(int postId) async {
    return checkItemsFailOrSuccess(commentApi.getComments(postId));
  }
}
