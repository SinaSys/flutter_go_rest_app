import 'package:clean_architecture_cubit/common/network/api_result.dart';
import 'package:clean_architecture_cubit/common/usecase/usecase.dart';
import 'package:clean_architecture_cubit/features/post/data/models/post.dart';
import 'package:clean_architecture_cubit/features/post/domain/repositories/post_repository.dart';

class DeletePostUseCase implements UseCase<bool, DeletePostParams> {
  final PostRepository postRepository;

  const DeletePostUseCase(this.postRepository);

  @override
  Future<ApiResult<bool>> call(DeletePostParams params) async {
    return await postRepository.deletePost(params.post);
  }
}

class DeletePostParams {
  final Post post;

  DeletePostParams(this.post);
}
