import 'package:clean_architecture_getx/features/comment/data/models/comment.dart';
import 'package:dartz/dartz.dart';


abstract class CommentRepository {
  Future<Either<String, List<Comment>>> getComments(int postId);

  Future<Either<String, bool>> createComment(Comment comment);

  Future<Either<String, bool>> deleteComment(Comment comment);
}
