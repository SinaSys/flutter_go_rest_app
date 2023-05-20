import 'package:clean_architecture_rxdart/common/usecase/usecase.dart';
import 'package:clean_architecture_rxdart/common/network/api_result.dart';
import 'package:clean_architecture_rxdart/features/post/data/models/post.dart';
import 'package:clean_architecture_rxdart/features/post/domain/repositories/post_repository.dart';

class CreatePostUseCase implements UseCase<bool, CreatePostParams> {
  final PostRepository postRepository;

  const CreatePostUseCase(this.postRepository);

  @override
  Future<ApiResult<bool>> call(CreatePostParams params) async {
    return await postRepository.createPost(params.post);
  }
}

class CreatePostParams {
  final Post post;

  const CreatePostParams(this.post);
}
