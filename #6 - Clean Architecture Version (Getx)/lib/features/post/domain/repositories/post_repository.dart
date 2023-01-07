import 'package:dartz/dartz.dart';

import '../../../user/data/models/user.dart';
import '../../data/models/post.dart';

abstract class PostRepository {
  Future<Either<String, List<Post>>> getPosts(User user);

  Future<Either<String, bool>> createPost(Post post);

  Future<Either<String, bool>> updatePost(Post post);

  Future<Either<String, bool>> deletePost(Post post);
}
