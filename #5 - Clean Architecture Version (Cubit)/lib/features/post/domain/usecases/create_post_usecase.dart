import 'package:clean_architecture_cubit/common/network/api_result.dart';
import 'package:clean_architecture_cubit/common/usecase/usecase.dart';
import 'package:clean_architecture_cubit/features/post/data/models/post.dart';
import 'package:clean_architecture_cubit/features/post/domain/repositories/post_repository.dart';

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

  CreatePostParams(this.post);
}
