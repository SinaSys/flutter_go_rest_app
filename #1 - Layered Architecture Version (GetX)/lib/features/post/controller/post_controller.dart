import 'package:layered_architecture/features/post/data/provider/remote/post_api.dart';
import 'package:layered_architecture/common/controller/base_controller.dart';
import 'package:layered_architecture/features/post/data/model/post.dart';
import 'package:layered_architecture/features/user/data/model/user.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

class PostController extends GetxController with StateMixin<List<Post>>, BaseController {
  final PostApi postApi = PostApi();

  RxInt postLength = 0.obs;

  void createPost(Post post) {
    createItem(postApi.createPost(post));
  }

  void updatePost(Post post) async {
    updateItem(postApi.updatePost(post));
  }

  void deletePost(Post post) async {
    deleteItem(postApi.deletePost(post));
  }

  Future<void> getPosts(User user) async {
    change(null, status: RxStatus.loading());

    Either<String, List<Post>> failureOrSuccess = await postApi.getPosts(user);

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
