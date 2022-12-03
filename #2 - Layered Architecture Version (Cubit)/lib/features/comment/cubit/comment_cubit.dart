import 'package:layered_architecture_cubit/common/cubit/generic_cubit.dart';

import '../data/model/comment.dart';
import '../data/provider/remote/comment_api.dart';

class CommentCubit extends GenericCubit<Comment> {
  final CommentApi _commentApi = CommentApi();

  Future<void> getUserComments(int postId) async {
    getItems(_commentApi.getUserComments(postId));
  }

  void createComment(Comment comment) async {
    createItem(_commentApi.createComment(comment));
  }

  void deleteComment(Comment comment) async {
    deleteItem(_commentApi.deleteComment(comment));
  }
}
