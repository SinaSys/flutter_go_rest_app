import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/riverpod/generic_provider.dart';
import '../../../../common/riverpod/generic_state.dart';
import '../../../../di.dart';
import '../../../user/data/models/user.dart';
import '../../data/models/post.dart';
import '../../domain/usecases/create_post_usecase.dart';
import '../../domain/usecases/delete_post_usecase.dart';
import '../../domain/usecases/get_posts_usecase.dart';
import '../../domain/usecases/update_post_usecase.dart';

final postProvider = StateNotifierProvider<PostNotifier, GenericState<Post>>(
  (_) => getIt<PostNotifier>(),
);

class PostNotifier extends GenericStateNotifier<Post> {
  final GetPostsUseCase getPostsUseCase;
  final CreatePostUseCase createPostUseCase;
  final UpdatePostUseCase updatePostUseCase;
  final DeletePostUseCase deletePostUseCase;

  PostNotifier({
    required this.getPostsUseCase,
    required this.createPostUseCase,
    required this.updatePostUseCase,
    required this.deletePostUseCase,
  });

  Future<void> getPosts(User user) async {
    getItems(getPostsUseCase.call(GetPostsParams(user: user)));
  }

  void createPost(Post post) async {
    createItem(createPostUseCase.call(CreatePostParams(post)));
  }

  void updatePost(Post post) async {
    updateItem(updatePostUseCase.call(UpdatePostParams(post)));
  }

  void deletePost(Post post) async {
    deleteItem(deletePostUseCase.call(DeletePostParams(post)));
  }
}
