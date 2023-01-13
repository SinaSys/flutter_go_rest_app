
import '../../../../common/network/api_result.dart';
import '../../../../common/usecase/usecase.dart';
import '../../data/models/comment.dart';
import '../repositories/comment_repository.dart';

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

  GetCommentsParams({required this.postId});
}
