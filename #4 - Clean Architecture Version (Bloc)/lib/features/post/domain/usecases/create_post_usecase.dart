import 'package:flutter/foundation.dart' show immutable;
import 'package:clean_architecture_bloc/common/usecase/usecase.dart';
import 'package:clean_architecture_bloc/common/network/api_result.dart';
import 'package:clean_architecture_bloc/features/post/data/models/post.dart';
import 'package:clean_architecture_bloc/features/post/domain/repositories/post_repository.dart';

@immutable
class CreatePostUseCase implements UseCase<bool, CreatePostParams> {
  final PostRepository postRepository;

  const CreatePostUseCase(this.postRepository);

  @override
  Future<ApiResult<bool>> call(CreatePostParams params) async {
    return await postRepository.createPost(params.post);
  }
}

@immutable
class CreatePostParams {
  final Post post;

  const CreatePostParams(this.post);
}
