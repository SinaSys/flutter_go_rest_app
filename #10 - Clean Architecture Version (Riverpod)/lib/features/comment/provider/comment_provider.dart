import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/riverpod/generic_provider.dart';
import '../../../common/riverpod/generic_state.dart';
import '../../../di.dart';
import '../data/models/comment.dart';
import '../domain/usecases/create_comment_usecase.dart';
import '../domain/usecases/delete_comment_usecase.dart';
import '../domain/usecases/get_comments_usecase.dart';

final commentProvider =
    StateNotifierProvider<CommentNotifier, GenericState<Comment>>(
  (_) => getIt<CommentNotifier>(),
);

class CommentNotifier extends GenericStateNotifier<Comment> {
  final GetCommentsUseCase getCommentsUseCase;
  final CreateCommentUseCase createCommentUseCase;
  final DeleteCommentUseCase deleteCommentUseCase;

  CommentNotifier({
    required this.getCommentsUseCase,
    required this.createCommentUseCase,
    required this.deleteCommentUseCase,
  });

  Future<void> getUserComments(int postId) async {
    getItems(getCommentsUseCase.call(GetCommentsParams(postId: postId)));
  }

  void createComment(Comment comment) async {
    createItem(createCommentUseCase.call(CreateCommentParams(comment)));
  }

  void deleteComment(Comment comment) async {
    deleteItem(deleteCommentUseCase.call(DeleteCommentParams(comment)));
  }
}
