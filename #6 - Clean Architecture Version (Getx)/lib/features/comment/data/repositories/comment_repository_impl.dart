import 'package:clean_architecture_getx/common/repository/repository_helper.dart';
import 'package:clean_architecture_getx/features/comment/data/datasources/comment_remote_data_source.dart';
import 'package:clean_architecture_getx/features/comment/data/models/comment.dart';
import 'package:clean_architecture_getx/features/comment/domain/repositories/comment_repository.dart';
import 'package:dartz/dartz.dart';

class CommentRepositoryImpl extends CommentRepository with RepositoryHelper<Comment> {
  final CommentRemoteDataSource remoteDataSource;

  CommentRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<String, bool>> createComment(Comment comment) async {
    return checkItemFailOrSuccess(remoteDataSource.createComment(comment));
  }

  @override
  Future<Either<String, bool>> deleteComment(Comment comment) async {
    return checkItemFailOrSuccess(remoteDataSource.deleteComment(comment));
  }

  @override
  Future<Either<String, List<Comment>>> getComments(int postId) async {
    return checkItemsFailOrSuccess(remoteDataSource.getComments(postId));
  }
}
