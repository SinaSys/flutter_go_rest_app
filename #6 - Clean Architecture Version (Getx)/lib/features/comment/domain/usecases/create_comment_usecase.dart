import 'package:clean_architecture_getx/common/usecase/usecase.dart';
import 'package:clean_architecture_getx/features/comment/data/models/comment.dart';
import 'package:clean_architecture_getx/features/comment/domain/repositories/comment_repository.dart';
import 'package:dartz/dartz.dart';

class CreateCommentUseCase implements UseCase<bool, CreateCommentParams> {
  final CommentRepository commentRepository;

  const CreateCommentUseCase(this.commentRepository);

  @override
  Future<Either<String, bool>> call(CreateCommentParams params) async {
    return await commentRepository.createComment(params.comment);
  }
}

class CreateCommentParams {
  final Comment comment;

  CreateCommentParams(this.comment);
}
