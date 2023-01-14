import 'package:clean_architecture_getx/common/repository/repository_helper.dart';
import 'package:clean_architecture_getx/features/post/data/datasources/post_remote_data_source.dart';
import 'package:clean_architecture_getx/features/post/data/models/post.dart';
import 'package:clean_architecture_getx/features/post/domain/repositories/post_repository.dart';
import 'package:clean_architecture_getx/features/user/data/models/user.dart';
import 'package:dartz/dartz.dart';

class PostRepositoryImpl extends PostRepository with RepositoryHelper<Post> {
  final PostRemoteDataSource remoteDataSource;

  PostRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<String, List<Post>>> getPosts(User user) async {
    return checkItemsFailOrSuccess(remoteDataSource.getUsers(user));
  }

  @override
  Future<Either<String, bool>> createPost(Post post) async {
    return checkItemFailOrSuccess(remoteDataSource.createPost(post));
  }

  @override
  Future<Either<String, bool>> updatePost(Post post) async {
    return checkItemFailOrSuccess(remoteDataSource.updatePost(post));
  }

  @override
  Future<Either<String, bool>> deletePost(Post post) async {
    return checkItemFailOrSuccess(remoteDataSource.deletePost(post));
  }
}
