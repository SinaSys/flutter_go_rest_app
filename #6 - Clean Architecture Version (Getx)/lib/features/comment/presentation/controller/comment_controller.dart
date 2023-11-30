import 'package:get/get.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:clean_architecture_getx/common/controller/base_controller.dart';
import 'package:clean_architecture_getx/features/comment/data/models/comment.dart';
import 'package:clean_architecture_getx/features/comment/domain/usecases/get_comments_usecase.dart';
import 'package:clean_architecture_getx/features/comment/domain/usecases/create_comment_usecase.dart';
import 'package:clean_architecture_getx/features/comment/domain/usecases/delete_comment_usecase.dart';

class CommentController extends GetxController with StateMixin<List<Comment>>, BaseController {
  final GetCommentsUseCase getCommentsUseCase;
  final CreateCommentUseCase createCommentUseCase;
  final DeleteCommentUseCase deleteCommentUseCase;

  @visibleForTesting
  Either<String, List<Comment>>? failureOrSuccess;

  CommentController({
    required this.getCommentsUseCase,
    required this.createCommentUseCase,
    required this.deleteCommentUseCase,
  });

  Future<void> createComment(Comment comment) async {
    createItem(
      createCommentUseCase.call(
        CreateCommentParams(comment),
      ),
    );
  }

  Future<void> deleteComment(Comment comment) async {
    deleteItem(
      deleteCommentUseCase.call(
        DeleteCommentParams(comment),
      ),
    );
  }

  Future<void> getUserComments(int postId) async {
    change(null, status: RxStatus.loading());
    failureOrSuccess = await getCommentsUseCase.call(GetCommentsParams(postId: postId));
    failureOrSuccess!.fold(
      (String failure) {
        change(null, status: RxStatus.error(failure));
      },
      (List<Comment> comments) {
        if (comments.isEmpty) {
          change(null, status: RxStatus.empty());
        } else {
          change(comments, status: RxStatus.success());
        }
      },
    );
  }
}
