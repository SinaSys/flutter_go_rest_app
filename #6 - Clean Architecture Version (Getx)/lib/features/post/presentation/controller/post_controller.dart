import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../../../common/controller/base_controller.dart';
import '../../../user/data/models/user.dart';
import '../../data/models/post.dart';
import '../../domain/usecases/create_post_usecase.dart';
import '../../domain/usecases/delete_post_usecase.dart';
import '../../domain/usecases/get_posts_usecase.dart';
import '../../domain/usecases/update_post_usecase.dart';

class PostController extends GetxController with StateMixin<List<Post>>, BaseController {
  RxInt postLength = 0.obs;

  final GetPostsUseCase getPostsUseCase;
  final CreatePostUseCase createPostUseCase;
  final UpdatePostUseCase updatePostUseCase;
  final DeletePostUseCase deletePostUseCase;

  PostController({
    required this.getPostsUseCase,
    required this.createPostUseCase,
    required this.updatePostUseCase,
    required this.deletePostUseCase,
  });

  void createPost(Post post) {
    createItem(createPostUseCase.call(CreatePostParams(post)));
  }

  void updatePost(Post post) async {
    updateItem(updatePostUseCase.call(UpdatePostParams(post)));
  }

  void deletePost(Post post) async {
    deleteItem(deletePostUseCase.call(DeletePostParams(post)));
  }

  Future<void> getPosts(User user) async {
    change(null, status: RxStatus.loading());
    Either<String, List<Post>> failureOrSuccess =
        (await getPostsUseCase.call(GetPostsParams(user: user)));
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
