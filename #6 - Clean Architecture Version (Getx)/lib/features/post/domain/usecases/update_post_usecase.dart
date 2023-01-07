import 'package:dartz/dartz.dart';

import '../../../../common/usecase/usecase.dart';
import '../../data/models/post.dart';
import '../repositories/post_repository.dart';

class UpdatePostUseCase implements UseCase<bool, UpdatePostParams> {
  final PostRepository postRepository;

  const UpdatePostUseCase(this.postRepository);

  @override
  Future<Either<String, bool>> call(UpdatePostParams params) async {
    return await postRepository.updatePost(params.post);
  }
}

class UpdatePostParams {
  final Post post;

  UpdatePostParams(this.post);
}
