import 'package:dartz/dartz.dart';

import '../../../../common/usecase/usecase.dart';
import '../../data/models/post.dart';
import '../repositories/post_repository.dart';

class CreatePostUseCase implements UseCase<bool, CreatePostParams> {
  final PostRepository postRepository;

  const CreatePostUseCase(this.postRepository);

  @override
  Future<Either<String, bool>> call(CreatePostParams params) async {
    return await postRepository.createPost(params.post);
  }
}

class CreatePostParams {
  final Post post;

  CreatePostParams(this.post);
}
