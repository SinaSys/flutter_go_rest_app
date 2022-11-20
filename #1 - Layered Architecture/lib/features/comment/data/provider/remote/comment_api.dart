import 'dart:convert';
import 'package:layered_architecture/features/comment/data/model/comment.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../../common/network/dio_client.dart';
import '../../../../../common/network/dio_exception.dart';
import '../../../../../core/api_config.dart';

class CommentApi {
  final DioClient _dioClient = DioClient();

  Future<Either<String, List<Comment>>> getUserComments(int postId) async {
    final queryParameters = {'post_id': "$postId"};
    try {
      final Response response = await _dioClient.dio!
          .get(ApiConfig.comments, queryParameters: queryParameters);

      final List<Comment> comments =
          commentFromJson(json.encode(response.data));
      return right(comments);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return left(errorMessage);
    }
  }
}
