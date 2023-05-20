import 'package:clean_architecture_rxdart/common/usecase/usecase.dart';
import 'package:clean_architecture_rxdart/common/network/api_result.dart';
import 'package:clean_architecture_rxdart/features/post/data/models/post.dart';
import 'package:clean_architecture_rxdart/features/post/domain/repositories/post_repository.dart';

class UpdatePostUseCase implements UseCase<bool, UpdatePostParams> {
  final PostRepository postRepository;

  const UpdatePostUseCase(this.postRepository);

  @override
  Future<ApiResult<bool>> call(UpdatePostParams params) async {
    return await postRepository.updatePost(params.post);
  }
}

class UpdatePostParams {
  final Post post;

  const UpdatePostParams(this.post);
}
