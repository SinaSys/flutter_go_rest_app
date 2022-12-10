import 'package:clean_architecture_bloc/common/network/api_result.dart';

import '../../../../common/usecase/usecase.dart';
import '../../data/models/comment.dart';
import '../repositories/comment_repository.dart';

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
