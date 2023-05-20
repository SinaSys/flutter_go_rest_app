import 'package:clean_architecture_rxdart/common/usecase/usecase.dart';
import 'package:clean_architecture_rxdart/common/network/api_result.dart';
import 'package:clean_architecture_rxdart/features/user/data/models/user.dart';
import 'package:clean_architecture_rxdart/features/post/data/models/post.dart';
import 'package:clean_architecture_rxdart/features/post/domain/repositories/post_repository.dart';

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

  const GetPostsParams({required this.user});
}
