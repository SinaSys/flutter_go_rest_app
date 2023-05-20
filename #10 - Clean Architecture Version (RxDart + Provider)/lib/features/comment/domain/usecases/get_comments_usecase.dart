import 'package:clean_architecture_rxdart/common/usecase/usecase.dart';
import 'package:clean_architecture_rxdart/common/network/api_result.dart';
import 'package:clean_architecture_rxdart/features/comment/data/models/comment.dart';
import 'package:clean_architecture_rxdart/features/comment/domain/repositories/comment_repository.dart';

class GetCommentsUseCase implements UseCase<List<Comment>, GetCommentsParams> {
  final CommentRepository commentRepository;

  const GetCommentsUseCase(this.commentRepository);

  @override
  Future<ApiResult<List<Comment>>> call(GetCommentsParams params) async {
    return await commentRepository.getComments(params.postId);
  }
}

class GetCommentsParams {
  final int postId;

  const GetCommentsParams({required this.postId});
}
