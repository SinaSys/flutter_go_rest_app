import 'package:layered_architecture/features/user/data/model/user.dart';
import 'package:layered_architecture/features/post/data/model/post.dart';
import 'package:layered_architecture/common/network/api_base.dart';
import 'package:layered_architecture/core/api_config.dart';
import 'package:dartz/dartz.dart';

class PostApi extends ApiBase {
  Future<Either<String, bool>> createPost(Post post) async {
    return await makePostRequest(
      path: ApiConfig.posts,
      data: post,
    );
  }

  Future<Either<String, bool>> updatePost(Post post) async {
    return await makePutRequest(
      path: "${ApiConfig.posts}/${post.id}",
      data: post,
    );
  }

  Future<Either<String, bool>> deletePost(Post post) async {
    return await makeDeleteRequest(
      path: "${ApiConfig.posts}/${post.id}",
    );
  }

  Future<Either<String, List<Post>>> getPosts(User user) async {
    final queryParameters = {'user_id': "${user.id}"};

    Future<Either<String, List<Post>>> result = makeGetRequest(
      path: ApiConfig.posts,
      queryParameters: queryParameters,
      getJsonCallback: Post.fromJson,
    );

    return result;
  }
}
