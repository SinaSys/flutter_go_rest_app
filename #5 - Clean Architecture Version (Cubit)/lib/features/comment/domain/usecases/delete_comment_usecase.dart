import 'package:clean_architecture_cubit/common/network/api_result.dart';
import 'package:clean_architecture_cubit/common/usecase/usecase.dart';
import 'package:clean_architecture_cubit/features/comment/data/models/comment.dart';
import 'package:clean_architecture_cubit/features/comment/domain/repositories/comment_repository.dart';

class DeleteCommentUseCase implements UseCase<bool, DeleteCommentParams> {
  final CommentRepository commentRepository;

  const DeleteCommentUseCase(this.commentRepository);

  @override
  Future<ApiResult<bool>> call(DeleteCommentParams params) async {
    return await commentRepository.deleteComment(params.comment);
  }
}

class DeleteCommentParams {
  final Comment comment;

  DeleteCommentParams(this.comment);
}
