import 'package:layered_architecture_cubit/features/post/data/model/post.dart';
import 'package:layered_architecture_cubit/features/user/data/model/user.dart';
import 'package:layered_architecture_cubit/common/network/api_result.dart';
import 'package:layered_architecture_cubit/common/network/api_base.dart';
import 'package:layered_architecture_cubit/core/api_config.dart';

class PostApi extends ApiBase {
  Future<ApiResult<bool>> createPost(Post post) async {
    return await makePostRequest(dioClient.dio!.post(ApiConfig.posts, data: post));
  }

  Future<ApiResult<bool>> updatePost(Post post) async {
    return await makePutRequest(dioClient.dio!.put("${ApiConfig.posts}/${post.id}", data: post));
  }

  Future<ApiResult<bool>> deletePost(Post post) async {
    return await makeDeleteRequest(dioClient.dio!.delete("${ApiConfig.posts}/${post.id}"));
  }

  Future<ApiResult<List<Post>>> getPosts(User user) async {
    final queryParameters = {'user_id': "${user.id}"};

    Future<ApiResult<List<Post>>> result = makeGetRequest(
      dioClient.dio!.get(ApiConfig.posts, queryParameters: queryParameters),
      Post.fromJson,
    );

    return result;
  }
}
