import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../common/network/dio_client.dart';
import '../../../../../common/network/dio_exception.dart';
import '../../../../../core/api_config.dart';
import '../../../../user/data/model/user.dart';
import '../../model/post.dart';

class PostApi {
  final DioClient _dioClient = DioClient();

  Future<Either<String, List<Post>>> getPosts(User user) async {
    final queryParameters = {'user_id': "${user.id}"};

    try {
      final Response response = await _dioClient.dio!
          .get(ApiConfig.posts, queryParameters: queryParameters);

      final List<Post> posts = postFromJson(json.encode(response.data));
      return right(posts);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return left(errorMessage);
    }
  }

  Future<Either<String, bool>> createPost(Post post) async {
    try {
      await _dioClient.dio!.post(ApiConfig.posts, data: post);
      return right(true);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return left(errorMessage);
    }
  }

  Future<Either<String, bool>> updatePost(Post post) async {
    try {
      await _dioClient.dio!.put("${ApiConfig.posts}/${post.id}", data: post);
      return right(true);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return left(errorMessage);
    }
  }

  Future<Either<String, bool>> deletePost(Post post) async {
    try {
      await _dioClient.dio!.delete("${ApiConfig.posts}/${post.id}");
      return right(true);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return left(errorMessage);
    }
  }
}
