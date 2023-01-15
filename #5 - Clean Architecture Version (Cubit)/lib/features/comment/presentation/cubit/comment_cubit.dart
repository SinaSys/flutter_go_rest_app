import 'package:clean_architecture_cubit/features/comment/domain/usecases/create_comment_usecase.dart';
import 'package:clean_architecture_cubit/features/comment/domain/usecases/delete_comment_usecase.dart';
import 'package:clean_architecture_cubit/features/comment/domain/usecases/get_comments_usecase.dart';
import 'package:clean_architecture_cubit/features/comment/data/models/comment.dart';
import 'package:clean_architecture_cubit/common/cubit/generic_cubit.dart';

class CommentCubit extends GenericCubit<Comment> {
  final GetCommentsUseCase getCommentsUseCase;
  final CreateCommentUseCase createCommentUseCase;
  final DeleteCommentUseCase deleteCommentUseCase;

  CommentCubit({
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
