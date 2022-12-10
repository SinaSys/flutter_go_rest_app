import 'package:clean_architecture_bloc/common/network/api_result.dart';

import '../../../../common/usecase/usecase.dart';
import '../../data/models/post.dart';
import '../repositories/post_repository.dart';

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
