import 'package:clean_architecture_getx/common/usecase/usecase.dart';
import 'package:clean_architecture_getx/features/post/data/models/post.dart';
import 'package:clean_architecture_getx/features/post/domain/repositories/post_repository.dart';
import 'package:dartz/dartz.dart';

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
