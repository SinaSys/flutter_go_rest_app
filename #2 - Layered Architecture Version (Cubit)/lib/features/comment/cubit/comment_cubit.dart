import '../../../common/cubit/generic_cubit.dart';
import '../data/model/comment.dart';
import '../data/provider/remote/comment_api.dart';

class CommentCubit extends GenericCubit<Comment> {
  final CommentApi commentApi = CommentApi();

  Future<void> getUserComments(int postId) async {
    getItems(commentApi.getUserComments(postId));
  }

  void createComment(Comment comment) async {
    createItem(commentApi.createComment(comment));
  }

  void deleteComment(Comment comment) async {
    deleteItem(commentApi.deleteComment(comment));
  }
}
