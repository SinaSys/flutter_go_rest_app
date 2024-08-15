import 'package:layered_architecture/features/user/data/model/user.dart';
import 'package:layered_architecture/features/post/data/model/post.dart';
import 'package:layered_architecture/common/network/api_base.dart';
import 'package:layered_architecture/core/api_config.dart';
import 'package:dartz/dartz.dart';

class PostApi extends ApiBase {
  Future<Either<String, bool>> createPost(Post post) async {
    return await makePostRequest(dioClient.dio!.post(ApiConfig.posts, data: post));
  }

  Future<Either<String, bool>> updatePost(Post post) async {
    return await makePutRequest(dioClient.dio!.put("${ApiConfig.posts}/${post.id}", data: post));
  }

  Future<Either<String, bool>> deletePost(Post post) async {
    return await makeDeleteRequest(dioClient.dio!.delete("${ApiConfig.posts}/${post.id}"));
  }

  Future<Either<String, List<Post>>> getPosts(User user) async {
    final queryParameters = {'user_id': "${user.id}"};

    Future<Either<String, List<Post>>> result = makeGetRequest(
      dioClient.dio!.get(ApiConfig.posts, queryParameters: queryParameters),
      Post.fromJson,
    );

    return result;
  }
}
