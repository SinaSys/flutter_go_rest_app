import '../../../../../common/network/api_base.dart';
import '../../../../../common/network/api_result.dart';
import '../../../../../core/api_config.dart';
import '../../../../user/data/model/user.dart';
import '../../model/post.dart';

class PostApi extends ApiBase<Post> {
  Future<ApiResult<List<Post>>> getPosts(User user) async {
    final queryParameters = {'user_id': "${user.id}"};

    Future<ApiResult<List<Post>>> result = getData(
      dioClient.dio!.get(ApiConfig.posts, queryParameters: queryParameters),
      Post.fromJson,
    );

    return result;
  }

  Future<ApiResult<bool>> createPost(Post post) async {
    return await requestMethodTemplate(
        dioClient.dio!.post(ApiConfig.posts, data: post));
  }

  Future<ApiResult<bool>> updatePost(Post post) async {
    return await requestMethodTemplate(
      dioClient.dio!.put("${ApiConfig.posts}/${post.id}", data: post),
    );
  }

  Future<ApiResult<bool>> deletePost(Post post) async {
    return await requestMethodTemplate(
      dioClient.dio!.delete("${ApiConfig.posts}/${post.id}"),
    );
  }
}
