import 'package:clean_architecture_bloc/common/network/api_result.dart';
import 'package:clean_architecture_bloc/features/comment/data/datasources/comment_remote_data_source.dart';
import 'package:clean_architecture_bloc/features/comment/data/models/comment.dart';
import 'package:clean_architecture_bloc/features/comment/domain/repositories/comment_repository.dart';

import '../../../../common/repository/repository_helper.dart';

class CommentRepositoryImpl extends CommentRepository with RepositoryHelper<Comment> {
  final CommentRemoteDataSource remoteDataSource;

  CommentRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ApiResult<bool>> createComment(Comment comment) async {
    return checkItemFailOrSuccess(remoteDataSource.createComment(comment));
  }

  @override
  Future<ApiResult<bool>> deleteComment(Comment comment) async {
    return checkItemFailOrSuccess(remoteDataSource.deleteComment(comment));
  }

  @override
  Future<ApiResult<List<Comment>>> getComments(int postId) async {
    return checkItemsFailOrSuccess(remoteDataSource.getComments(postId));
  }
}
