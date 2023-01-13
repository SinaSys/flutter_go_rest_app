
import '../../../../common/network/api_result.dart';
import '../../../../common/usecase/usecase.dart';
import '../../../user/data/models/user.dart';
import '../../data/models/post.dart';
import '../repositories/post_repository.dart';

class GetPostsUseCase implements UseCase<List<Post>, GetPostsParams> {
  final PostRepository postRepository;

  const GetPostsUseCase(this.postRepository);

  @override
  Future<ApiResult<List<Post>>> call(GetPostsParams params) async {
    return await postRepository.getPosts(params.user);
  }
}

class GetPostsParams {
  final User user;

  GetPostsParams({required this.user});
}
