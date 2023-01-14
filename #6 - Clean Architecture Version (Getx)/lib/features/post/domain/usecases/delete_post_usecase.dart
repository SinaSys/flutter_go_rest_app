import 'package:clean_architecture_getx/common/usecase/usecase.dart';
import 'package:clean_architecture_getx/features/post/data/models/post.dart';
import 'package:clean_architecture_getx/features/post/domain/repositories/post_repository.dart';
import 'package:dartz/dartz.dart';

class DeletePostUseCase implements UseCase<bool, DeletePostParams> {
  final PostRepository postRepository;

  const DeletePostUseCase(this.postRepository);

  @override
  Future<Either<String, bool>> call(DeletePostParams params) async {
    return await postRepository.deletePost(params.post);
  }
}

class DeletePostParams {
  final Post post;

  DeletePostParams(this.post);
}
