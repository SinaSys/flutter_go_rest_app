import 'package:clean_architecture_bloc/common/network/api_result.dart';

import '../../../../common/usecase/usecase.dart';
import '../../data/models/post.dart';
import '../repositories/post_repository.dart';

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
