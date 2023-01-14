import 'package:clean_architecture_getx/features/post/domain/repositories/post_repository.dart';
import 'package:clean_architecture_getx/features/post/data/models/post.dart';
import 'package:clean_architecture_getx/common/usecase/usecase.dart';
import 'package:clean_architecture_getx/features/user/data/models/user.dart';
import 'package:dartz/dartz.dart';

class GetPostsUseCase implements UseCase<List<Post>, GetPostsParams> {
  final PostRepository postRepository;

  const GetPostsUseCase(this.postRepository);

  @override
  Future<Either<String, List<Post>>> call(GetPostsParams params) async {
    return await postRepository.getPosts(params.user);
  }
}

class GetPostsParams {
  final User user;

  GetPostsParams({required this.user});
}
