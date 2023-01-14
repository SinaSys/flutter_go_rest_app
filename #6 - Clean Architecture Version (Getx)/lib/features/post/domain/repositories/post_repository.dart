import 'package:clean_architecture_getx/features/post/data/models/post.dart';
import 'package:clean_architecture_getx/features/user/data/models/user.dart';
import 'package:dartz/dartz.dart';

abstract class PostRepository {
  Future<Either<String, List<Post>>> getPosts(User user);

  Future<Either<String, bool>> createPost(Post post);

  Future<Either<String, bool>> updatePost(Post post);

  Future<Either<String, bool>> deletePost(Post post);
}
