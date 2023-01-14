import 'package:clean_architecture_getx/common/usecase/usecase.dart';
import 'package:clean_architecture_getx/features/comment/data/models/comment.dart';
import 'package:clean_architecture_getx/features/comment/domain/repositories/comment_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteCommentUseCase implements UseCase<bool, DeleteCommentParams> {
  final CommentRepository commentRepository;

  const DeleteCommentUseCase(this.commentRepository);

  @override
  Future<Either<String, bool>> call(DeleteCommentParams params) async {
    return await commentRepository.deleteComment(params.comment);
  }
}

class DeleteCommentParams {
  final Comment comment;

  DeleteCommentParams(this.comment);
}
