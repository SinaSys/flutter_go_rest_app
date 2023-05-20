import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:clean_architecture_getx/common/usecase/usecase.dart';
import 'package:clean_architecture_getx/features/post/data/models/post.dart';
import 'package:clean_architecture_getx/features/post/domain/repositories/post_repository.dart';

@immutable
class DeletePostUseCase implements UseCase<bool, DeletePostParams> {
  final PostRepository postRepository;

  const DeletePostUseCase(this.postRepository);

  @override
  Future<Either<String, bool>> call(DeletePostParams params) async {
    return await postRepository.deletePost(params.post);
  }
}

@immutable
class DeletePostParams {
  final Post post;

  const DeletePostParams(this.post);
}
