import 'package:mvvm_getx/common/repository/repository_helper.dart';
import 'package:mvvm_getx/data/api/post/post_api.dart';
import 'package:mvvm_getx/data/model/post/post.dart';
import 'package:mvvm_getx/data/model/user/user.dart';
import 'package:dartz/dartz.dart';

class PostRepository with RepositoryHelper<Post> {
  final PostApi postApi;

  const PostRepository({required this.postApi});

  Future<Either<String, List<Post>>> getPosts(User user) async {
    return checkItemsFailOrSuccess(postApi.getUsers(user));
  }

  Future<Either<String, bool>> createPost(Post post) async {
    return checkItemFailOrSuccess(postApi.createPost(post));
  }

  Future<Either<String, bool>> updatePost(Post post) async {
    return checkItemFailOrSuccess(postApi.updatePost(post));
  }

  Future<Either<String, bool>> deletePost(Post post) async {
    return checkItemFailOrSuccess(postApi.deletePost(post));
  }
}
