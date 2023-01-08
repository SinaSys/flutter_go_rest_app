import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../../../common/controller/base_controller.dart';
import '../../data/models/comment.dart';
import '../../domain/usecases/create_comment_usecase.dart';
import '../../domain/usecases/delete_comment_usecase.dart';
import '../../domain/usecases/get_comments_usecase.dart';

class CommentController extends GetxController
    with StateMixin<List<Comment>>, BaseController {
  final GetCommentsUseCase getCommentsUseCase;
  final CreateCommentUseCase createCommentUseCase;
  final DeleteCommentUseCase deleteCommentUseCase;

  CommentController({
    required this.getCommentsUseCase,
    required this.createCommentUseCase,
    required this.deleteCommentUseCase,
  });

  void createComment(Comment comment) {
    createItem(createCommentUseCase.call(CreateCommentParams(comment)));
  }

  void deleteComment(Comment comment) {
    deleteItem(deleteCommentUseCase.call(DeleteCommentParams(comment)));
  }

  Future<void> getUserComments(int postId) async {
    change(null, status: RxStatus.loading());
    final Either<String, List<Comment>> failureOrSuccess =
        (await getCommentsUseCase.call(GetCommentsParams(postId: postId)));
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
