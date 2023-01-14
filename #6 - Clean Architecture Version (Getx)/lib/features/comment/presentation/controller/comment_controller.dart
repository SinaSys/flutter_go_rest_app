import 'package:clean_architecture_getx/common/controller/base_controller.dart';
import 'package:clean_architecture_getx/features/comment/data/models/comment.dart';
import 'package:clean_architecture_getx/features/comment/domain/usecases/create_comment_usecase.dart';
import 'package:clean_architecture_getx/features/comment/domain/usecases/delete_comment_usecase.dart';
import 'package:clean_architecture_getx/features/comment/domain/usecases/get_comments_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

class CommentController extends GetxController with StateMixin<List<Comment>>, BaseController {
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
