import 'package:mvvm_bloc/common/repository/repository_helper.dart';
import 'package:mvvm_bloc/common/network/api_result.dart';
import 'package:mvvm_bloc/data/api/post/post_api.dart';
import 'package:mvvm_bloc/data/model/post/post.dart';
import 'package:mvvm_bloc/data/model/user/user.dart';

class PostRepository with RepositoryHelper<Post> {
  final PostApi postApi;

  const PostRepository({required this.postApi});

  Future<ApiResult<List<Post>>> getPosts(User user) async {
    return checkItemsFailOrSuccess(postApi.getUsers(user));
  }

  Future<ApiResult<bool>> createPost(Post post) async {
    return checkItemFailOrSuccess(postApi.createPost(post));
  }

  Future<ApiResult<bool>> updatePost(Post post) async {
    return checkItemFailOrSuccess(postApi.updatePost(post));
  }

  Future<ApiResult<bool>> deletePost(Post post) async {
    return checkItemFailOrSuccess(postApi.deletePost(post));
  }
}
