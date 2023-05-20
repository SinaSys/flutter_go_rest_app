import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:clean_architecture_getx/common/usecase/usecase.dart';
import 'package:clean_architecture_getx/features/comment/data/models/comment.dart';
import 'package:clean_architecture_getx/features/comment/domain/repositories/comment_repository.dart';

@immutable
class CreateCommentUseCase implements UseCase<bool, CreateCommentParams> {
  final CommentRepository commentRepository;

  const CreateCommentUseCase(this.commentRepository);

  @override
  Future<Either<String, bool>> call(CreateCommentParams params) async {
    return await commentRepository.createComment(params.comment);
  }
}

@immutable
class CreateCommentParams {
  final Comment comment;

  const CreateCommentParams(this.comment);
}
