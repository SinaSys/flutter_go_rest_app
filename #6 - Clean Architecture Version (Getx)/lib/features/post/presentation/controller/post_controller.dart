import 'package:get/get.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:clean_architecture_getx/features/user/data/models/user.dart';
import 'package:clean_architecture_getx/features/post/data/models/post.dart';
import 'package:clean_architecture_getx/common/controller/base_controller.dart';
import 'package:clean_architecture_getx/features/post/domain/usecases/create_post_usecase.dart';
import 'package:clean_architecture_getx/features/post/domain/usecases/delete_post_usecase.dart';
import 'package:clean_architecture_getx/features/post/domain/usecases/get_posts_usecase.dart';
import 'package:clean_architecture_getx/features/post/domain/usecases/update_post_usecase.dart';

class PostController extends GetxController with StateMixin<List<Post>>, BaseController {
  RxInt postLength = 0.obs;

  final GetPostsUseCase getPostsUseCase;
  final CreatePostUseCase createPostUseCase;
  final UpdatePostUseCase updatePostUseCase;
  final DeletePostUseCase deletePostUseCase;

  @visibleForTesting
  late Either<String, List<Post>> failureOrSuccess;

  PostController({
    required this.getPostsUseCase,
    required this.createPostUseCase,
    required this.updatePostUseCase,
    required this.deletePostUseCase,
  });

  Future<void> createPost(Post post) async {
    createItem(createPostUseCase.call(CreatePostParams(post)));
  }

  Future<void> updatePost(Post post) async {
    updateItem(updatePostUseCase.call(UpdatePostParams(post)));
  }

  Future<void> deletePost(Post post) async {
    deleteItem(deletePostUseCase.call(DeletePostParams(post)));
  }

  Future<void> getPosts(User user) async {
    change(null, status: RxStatus.loading());
    failureOrSuccess = (await getPostsUseCase.call(GetPostsParams(user: user)));
    failureOrSuccess.fold(
      (String failure) {
        change(null, status: RxStatus.error(failure));
      },
      (List<Post> posts) {
        postLength.value = posts.length;
        if (posts.isEmpty) {
          change(posts, status: RxStatus.empty());
        } else {
          change(posts, status: RxStatus.success());
        }
      },
    );
  }
}
