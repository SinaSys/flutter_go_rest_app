import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:clean_architecture_getx/common/usecase/usecase.dart';
import 'package:clean_architecture_getx/features/post/data/models/post.dart';
import 'package:clean_architecture_getx/features/post/domain/repositories/post_repository.dart';

@immutable
class CreatePostUseCase implements UseCase<bool, CreatePostParams> {
  final PostRepository postRepository;

  const CreatePostUseCase(this.postRepository);

  @override
  Future<Either<String, bool>> call(CreatePostParams params) async {
    return await postRepository.createPost(params.post);
  }
}

@immutable
class CreatePostParams {
  final Post post;

  const CreatePostParams(this.post);
}
