import 'package:clean_architecture_rxdart/common/usecase/usecase.dart';
import 'package:clean_architecture_rxdart/common/network/api_result.dart';
import 'package:clean_architecture_rxdart/features/comment/data/models/comment.dart';
import 'package:clean_architecture_rxdart/features/comment/domain/repositories/comment_repository.dart';

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

  const CreateCommentParams(this.comment);
}
