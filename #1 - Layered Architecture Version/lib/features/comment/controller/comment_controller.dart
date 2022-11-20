import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../data/model/comment.dart';
import '../data/provider/remote/comment_api.dart';

class CommentController extends GetxController with StateMixin<List<Comment>> {
  Rx<Either<String, List<Comment>>>? comments;

  final CommentApi _commentApi = CommentApi();

  Future<bool> getUserComments(int postId) async {
    change(null, status: RxStatus.loading());
    comments = (await _commentApi.getUserComments(postId)).obs;
    comments?.value.fold(
      (String failure) {
        change(null, status: RxStatus.error(failure));
        return false;
      },
      (List<Comment> comments) {
        if (comments.isEmpty) {
          change(null, status: RxStatus.empty());
          return true;
        } else {
          change(comments, status: RxStatus.success());
          return true;
        }
      },
    );
    return false;
  }
}
