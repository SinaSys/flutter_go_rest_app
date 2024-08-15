import 'package:clean_architecture_getx/common/network/api_base.dart';
import 'package:clean_architecture_getx/common/network/api_config.dart';
import 'package:clean_architecture_getx/common/network/dio_client.dart';
import 'package:clean_architecture_getx/features/post/data/models/post.dart';
import 'package:clean_architecture_getx/features/user/data/models/user.dart';

abstract class PostRemoteDataSource {
  Future<List<Post>> getUsers(User user);

  Future<bool> createPost(Post post);

  Future<bool> updatePost(Post post);

  Future<bool> deletePost(Post post);
}

class PostRemoteDataSourceImpl with ApiBase implements PostRemoteDataSource {
  final DioClient dioClient;

  const PostRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<bool> createPost(Post post) async {
    return await makePostRequest(
      dioClient.post(ApiConfig.posts, data: post),
    );
  }

  @override
  Future<bool> updatePost(Post post) async {
    return await makePutRequest(
      dioClient.put("${ApiConfig.posts}/${post.id}", data: post),
    );
  }

  @override
  Future<bool> deletePost(Post post) async {
    return await makeDeleteRequest(
      dioClient.delete("${ApiConfig.posts}/${post.id}"),
    );
  }

  @override
  Future<List<Post>> getUsers(User user) async {
    final queryParameters = {'user_id': "${user.id}"};

    return await makeGetRequest(
      dioClient.get(ApiConfig.posts, queryParameters: queryParameters),
      Post.fromJson,
    );
  }
}
