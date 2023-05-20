import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:clean_architecture_getx/common/usecase/usecase.dart';
import 'package:clean_architecture_getx/features/comment/data/models/comment.dart';
import 'package:clean_architecture_getx/features/comment/domain/repositories/comment_repository.dart';

@immutable
class GetCommentsUseCase implements UseCase<List<Comment>, GetCommentsParams> {
  final CommentRepository commentRepository;

  const GetCommentsUseCase(this.commentRepository);

  @override
  Future<Either<String, List<Comment>>> call(GetCommentsParams params) async {
    return await commentRepository.getComments(params.postId);
  }
}

@immutable
class GetCommentsParams {
  final int postId;

  const GetCommentsParams({required this.postId});
}
