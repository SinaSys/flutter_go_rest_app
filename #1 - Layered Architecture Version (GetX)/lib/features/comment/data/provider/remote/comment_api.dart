import 'package:layered_architecture/features/comment/data/model/comment.dart';
import 'package:layered_architecture/common/network/api_base.dart';
import 'package:layered_architecture/core/api_config.dart';
import 'package:dartz/dartz.dart';

class CommentApi extends ApiBase {
  Future<Either<String, bool>> createComment(Comment comment) async {
    return await makePostRequest(path: ApiConfig.comments, data: comment);
  }

  Future<Either<String, bool>> deleteComment(Comment comment) async {
    return await makeDeleteRequest(path: "${ApiConfig.comments}/${comment.id}");
  }

  Future<Either<String, List<Comment>>> getUserComments(int postId) async {
    final queryParameters = {'post_id': "$postId"};

    Future<Either<String, List<Comment>>> result = makeGetRequest(
      path: ApiConfig.comments,
      queryParameters: queryParameters,
      getJsonCallback: Comment.fromJson,
    );

    return result;
  }
}
