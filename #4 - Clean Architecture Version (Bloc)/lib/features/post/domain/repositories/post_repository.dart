import 'package:clean_architecture_bloc/common/network/api_result.dart';
import 'package:clean_architecture_bloc/features/post/data/models/post.dart';
import 'package:clean_architecture_bloc/features/user/data/models/user.dart';

abstract class PostRepository {
  Future<ApiResult<List<Post>>> getPosts(User user);

  Future<ApiResult<bool>> createPost(Post post);

  Future<ApiResult<bool>> updatePost(Post post);

  Future<ApiResult<bool>> deletePost(Post post);
}
