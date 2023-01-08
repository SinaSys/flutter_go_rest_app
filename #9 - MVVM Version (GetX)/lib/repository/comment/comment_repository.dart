import 'package:dartz/dartz.dart';

import '../../../../common/repository/repository_helper.dart';
import '../../data/api/comment/comment_api.dart';
import '../../data/model/comment/comment.dart';

class CommentRepository with RepositoryHelper<Comment> {
  final CommentApi commentApi;

  CommentRepository({required this.commentApi});

  Future<Either<String, bool>> createComment(Comment comment) async {
    return checkItemFailOrSuccess(commentApi.createComment(comment));
  }

  Future<Either<String, bool>> deleteComment(Comment comment) async {
    return checkItemFailOrSuccess(commentApi.deleteComment(comment));
  }

  Future<Either<String, List<Comment>>> getComments(int postId) async {
    return checkItemsFailOrSuccess(commentApi.getComments(postId));
  }
}
