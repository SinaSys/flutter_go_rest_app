import 'package:clean_architecture_bloc/common/network/api_result.dart';
import 'package:clean_architecture_bloc/features/comment/domain/repositories/comment_repository.dart';

import '../../../../common/usecase/usecase.dart';
import '../../data/models/comment.dart';

class CreateCommentUseCase implements UseCase<bool, CreateCommentParams> {
  final CommentRepository commentRepository;

  const CreateCommentUseCase(this.commentRepository);

  @override
  Future<ApiResult<bool>> call(CreateCommentParams params) async {
    return await commentRepository.createComment(params.comment);
  }
}

class CreateCommentParams {
  final Comment comment;

  CreateCommentParams(this.comment);
}
