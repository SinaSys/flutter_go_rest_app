import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../user/data/model/user.dart';
import '../data/model/post.dart';
import '../data/provider/remote/post_api.dart';

enum PostStatus { loading, success, failure }

class PostController extends GetxController with StateMixin<List<Post>> {
  final PostApi _postApi = PostApi();
  Rx<PostStatus> postStatus = PostStatus.loading.obs;
  Rx<String> errorMessage = "".obs;

  RxInt postLength = 0.obs;

  Future<bool> getPosts(User user) async {
    change(null, status: RxStatus.loading());
    Either<String, List<Post>> failureOrSuccess = await _postApi.getPosts(user);
    failureOrSuccess.fold(
      (String failure) {
        change(null, status: RxStatus.error(failure));
        return false;
      },
      (List<Post> posts) {
        postLength.value = posts.length;
        if (posts.isEmpty) {
          change(posts, status: RxStatus.empty());
        } else {
          change(posts, status: RxStatus.success());
        }

        return true;
      },
    );
    return false;
  }

  //Method template for crete/update and delete operation
  void postOperationTemplate(Future<Either<String, bool>> apiCallback) async {
    postStatus.value = PostStatus.loading;
    Either<String, bool> failureOrSuccess = await apiCallback;

    failureOrSuccess.fold(
      (String failure) {
        postStatus.value = PostStatus.failure;
        errorMessage = failure.obs;
      },
      (bool success) {
        postStatus.value = PostStatus.success;
      },
    );
  }

  void createPost(Post post) {
    postOperationTemplate(_postApi.createPost(post));
  }

  void updatePost(Post post) async {
    postOperationTemplate(_postApi.updatePost(post));
  }

  void deletePost(Post post) async {
    postOperationTemplate(_postApi.deletePost(post));
  }
}
