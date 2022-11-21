import 'package:dartz/dartz.dart';

import '../../../../../common/network/api_base.dart';
import '../../../../../core/api_config.dart';
import '../../../../user/data/model/user.dart';
import '../../model/post.dart';

class PostApi extends ApiBase<Post> {
  Future<Either<String, List<Post>>> getPosts(User user) async {
    final queryParameters = {'user_id': "${user.id}"};

    Future<Either<String, List<Post>>> result = getData(
      dioClient.dio!.get(ApiConfig.posts, queryParameters: queryParameters),
      Post.fromJson,
    );

    return result;
  }

  Future<Either<String, bool>> createPost(Post post) async {
    return await requestMethodTemplate(
        dioClient.dio!.post(ApiConfig.posts, data: post));
  }

  Future<Either<String, bool>> updatePost(Post post) async {
    return await requestMethodTemplate(
      dioClient.dio!.put("${ApiConfig.posts}/${post.id}", data: post),
    );
  }

  Future<Either<String, bool>> deletePost(Post post) async {
    return await requestMethodTemplate(
      dioClient.dio!.delete("${ApiConfig.posts}/${post.id}"),
    );
  }
}
