import 'package:flutter/foundation.dart' show immutable;
import 'package:clean_architecture_cubit/common/usecase/usecase.dart';
import 'package:clean_architecture_cubit/common/network/api_result.dart';
import 'package:clean_architecture_cubit/features/post/data/models/post.dart';
import 'package:clean_architecture_cubit/features/post/domain/repositories/post_repository.dart';

@immutable
class DeletePostUseCase implements UseCase<bool, DeletePostParams> {
  final PostRepository postRepository;

  const DeletePostUseCase(this.postRepository);

  @override
  Future<ApiResult<bool>> call(DeletePostParams params) async {
    return await postRepository.deletePost(params.post);
  }
}

@immutable
class DeletePostParams {
  final Post post;

  const DeletePostParams(this.post);
}
