import '../../../common/cubit/generic_cubit.dart';
import '../../../data/model/comment/comment.dart';
import '../../../repository/comment/comment_repository.dart';

class CommentCubit extends GenericCubit<Comment> {
  final CommentRepository commentRepository;

  CommentCubit({required this.commentRepository});

  Future<void> getUserComments(int postId) async {
    getItems(commentRepository.getComments(postId));
  }

  void createComment(Comment comment) async {
    createItem(commentRepository.createComment(comment));
  }

  void deleteComment(Comment comment) async {
    deleteItem(commentRepository.deleteComment(comment));
  }
}
