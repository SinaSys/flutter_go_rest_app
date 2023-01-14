import 'package:clean_architecture_getx/common/usecase/usecase.dart';
import 'package:clean_architecture_getx/features/comment/data/models/comment.dart';
import 'package:clean_architecture_getx/features/comment/domain/repositories/comment_repository.dart';
import 'package:dartz/dartz.dart';

class GetCommentsUseCase implements UseCase<List<Comment>, GetCommentsParams> {
  final CommentRepository commentRepository;

  const GetCommentsUseCase(this.commentRepository);

  @override
  Future<Either<String, List<Comment>>> call(GetCommentsParams params) async {
    return await commentRepository.getComments(params.postId);
  }
}

class GetCommentsParams {
  final int postId;

  GetCommentsParams({required this.postId});
}
