import '../../../../common/network/api_result.dart';
import '../../../user/data/models/user.dart';
import '../../data/models/post.dart';

abstract class PostRepository {
  Future<ApiResult<List<Post>>> getPosts(User user);

  Future<ApiResult<bool>> createPost(Post post);

  Future<ApiResult<bool>> updatePost(Post post);

  Future<ApiResult<bool>> deletePost(Post post);
}
