import 'package:mvvm_bloc/data/model/comment/comment.dart';

abstract class CommentEvent {}

class CommentFetched extends CommentEvent {
  final int postId;

  CommentFetched(this.postId);
}

class CommentCreated extends CommentEvent {
  final Comment comment;

  CommentCreated(this.comment);
}

class CommentDeleted extends CommentEvent {
  final Comment comment;

  CommentDeleted(this.comment);
}
