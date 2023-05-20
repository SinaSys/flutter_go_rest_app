import 'package:clean_architecture_rxdart/common/usecase/usecase.dart';
import 'package:clean_architecture_rxdart/common/network/api_result.dart';
import 'package:clean_architecture_rxdart/features/comment/data/models/comment.dart';
import 'package:clean_architecture_rxdart/features/comment/domain/repositories/comment_repository.dart';

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

  const DeleteCommentParams(this.comment);
}
