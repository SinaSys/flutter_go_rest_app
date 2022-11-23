import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../../common/controller/api_operation.dart';
import '../data/model/comment.dart';
import '../data/provider/remote/comment_api.dart';

class CommentController extends GetxController
    with StateMixin<List<Comment>>, ApiOperationMixin {
  Rx<Either<String, List<Comment>>>? comments;

  final CommentApi _commentApi = CommentApi();

  Future<void> getUserComments(int postId) async {
    change(null, status: RxStatus.loading());
    comments = (await _commentApi.getUserComments(postId)).obs;
    comments?.value.fold(
      (String failure) {
        change(null, status: RxStatus.error(failure));
      },
      (List<Comment> comments) {
        if (comments.isEmpty) {
          change(null, status: RxStatus.empty());
          return true;
        } else {
          change(comments, status: RxStatus.success());
        }
      },
    );
  }

  void createComment(Comment comment) {
    requestMethodTemplate(_commentApi.createComment(comment));
  }

  void deleteComment(Comment comment) {
    requestMethodTemplate(_commentApi.deleteComment(comment));
  }
}
