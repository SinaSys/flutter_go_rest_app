import 'package:clean_architecture_getx/common/usecase/usecase.dart';
import 'package:clean_architecture_getx/features/post/data/models/post.dart';
import 'package:clean_architecture_getx/features/post/domain/repositories/post_repository.dart';
import 'package:dartz/dartz.dart';

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
