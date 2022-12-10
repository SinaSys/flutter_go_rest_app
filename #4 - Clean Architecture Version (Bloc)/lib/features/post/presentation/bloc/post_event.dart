import '../../../user/data/models/user.dart';
import '../../data/models/post.dart';

abstract class PostEvent {}

class PostFetched extends PostEvent {
  final User user;

  PostFetched(this.user);
}

class PostCreated extends PostEvent {
  final Post post;

  PostCreated(this.post);
}

class PostUpdated extends PostEvent {
  final Post post;

  PostUpdated(this.post);
}

class PostDeleted extends PostEvent {
  final Post post;

  PostDeleted(this.post);
}
