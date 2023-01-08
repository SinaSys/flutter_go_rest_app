import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../../common/controller/base_controller.dart';
import '../../../data/model/comment/comment.dart';
import '../../../repository/comment/comment_repository.dart';

class CommentController extends GetxController with StateMixin<List<Comment>>, BaseController {
  final CommentRepository commentRepository;

  CommentController({required this.commentRepository});

  void createComment(Comment comment) {
    createItem(commentRepository.createComment(comment));
  }

  void deleteComment(Comment comment) {
    deleteItem(commentRepository.deleteComment(comment));
  }

  Future<void> getUserComments(int postId) async {
    change(null, status: RxStatus.loading());
    final Either<String, List<Comment>> failureOrSuccess = (await commentRepository.getComments(postId));

    failureOrSuccess.fold(
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
}
