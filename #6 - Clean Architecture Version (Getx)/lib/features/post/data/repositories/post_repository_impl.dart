import 'package:dartz/dartz.dart';

import '../../../../common/repository/repository_helper.dart';
import '../../../user/data/models/user.dart';
import '../../domain/repositories/post_repository.dart';
import '../datasources/post_remote_data_source.dart';
import '../models/post.dart';

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
