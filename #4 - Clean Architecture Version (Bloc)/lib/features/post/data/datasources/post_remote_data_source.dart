import 'package:clean_architecture_bloc/common/network/api_helper.dart';

import '../../../../common/network/api_config.dart';
import '../../../../common/network/dio_client.dart';
import '../../../../di.dart';
import '../../../user/data/models/user.dart';
import '../models/post.dart';

abstract class PostRemoteDataSource {
  Future<List<Post>> getUsers(User user);

  Future<bool> createPost(Post post);

  Future<bool> updatePost(Post post);

  Future<bool> deletePost(Post post);
}

class PostRemoteDataSourceImpl with ApiHelper<Post> implements PostRemoteDataSource {
  final DioClient dioClient = getIt<DioClient>();

  @override
  Future<bool> createPost(Post post) async {
    return await makePostRequest(dioClient.dio.post(ApiConfig.posts, data: post));
  }

  @override
  Future<bool> updatePost(Post post) async {
    return await makePutRequest(dioClient.dio.put("${ApiConfig.posts}/${post.id}", data: post));
  }

  @override
  Future<bool> deletePost(Post post) async {
    return await makeDeleteRequest(dioClient.dio.delete("${ApiConfig.posts}/${post.id}"));
  }

  @override
  Future<List<Post>> getUsers(User user) async {
    final queryParameters = {'user_id': "${user.id}"};

    return await makeGetRequest(
        dioClient.dio.get(ApiConfig.posts, queryParameters: queryParameters),
        Post.fromJson);
  }
}
