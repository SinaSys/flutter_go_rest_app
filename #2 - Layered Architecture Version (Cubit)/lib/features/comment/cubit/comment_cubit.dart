import 'package:layered_architecture_cubit/features/comment/data/provider/remote/comment_api.dart';
import 'package:layered_architecture_cubit/features/comment/data/model/comment.dart';
import 'package:layered_architecture_cubit/common/cubit/generic_cubit.dart';

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
