import 'package:dartz/dartz.dart';

import '../../data/models/comment.dart';

abstract class CommentRepository {
  Future<Either<String, List<Comment>>> getComments(int postId);

  Future<Either<String, bool>> createComment(Comment comment);

  Future<Either<String, bool>> deleteComment(Comment comment);
}
