import 'package:dartz/dartz.dart';
import '../../../../../common/network/api_base.dart';
import '../../../../../core/api_config.dart';
import '../../model/comment.dart';

class CommentApi extends ApiBase<Comment> {

  Future<Either<String, bool>> createComment(Comment comment) async {
    return await makePostRequest(dioClient.dio!.post(ApiConfig.comments, data: comment));
  }

  Future<Either<String, bool>> deleteComment(Comment comment) async {
    return await makeDeleteRequest(dioClient.dio!.delete("${ApiConfig.comments}/${comment.id}"));
  }

  Future<Either<String, List<Comment>>> getUserComments(int postId) async {

    final queryParameters = {'post_id': "$postId"};

    Future<Either<String, List<Comment>>> result = makeGetRequest(
      dioClient.dio!.get(ApiConfig.comments, queryParameters: queryParameters),
      Comment.fromJson,
    );

    return result;
  }
}
