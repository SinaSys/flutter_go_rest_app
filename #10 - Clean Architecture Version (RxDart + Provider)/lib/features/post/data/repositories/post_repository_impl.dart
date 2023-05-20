import 'package:clean_architecture_rxdart/common/network/api_result.dart';
import 'package:clean_architecture_rxdart/features/post/data/models/post.dart';
import 'package:clean_architecture_rxdart/features/user/data/models/user.dart';
import 'package:clean_architecture_rxdart/common/repository/repository_helper.dart';
import 'package:clean_architecture_rxdart/features/post/domain/repositories/post_repository.dart';
import 'package:clean_architecture_rxdart/features/post/data/datasources/post_remote_data_source.dart';

class PostRepositoryImpl extends PostRepository with RepositoryHelper<Post> {
  final PostRemoteDataSource remoteDataSource;

  PostRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ApiResult<List<Post>>> getPosts(User user) async {
    return checkItemsFailOrSuccess(remoteDataSource.getUsers(user));
  }

  @override
  Future<ApiResult<bool>> createPost(Post post) async {
    return checkItemFailOrSuccess(remoteDataSource.createPost(post));
  }

  @override
  Future<ApiResult<bool>> updatePost(Post post) async {
    return checkItemFailOrSuccess(remoteDataSource.updatePost(post));
  }

  @override
  Future<ApiResult<bool>> deletePost(Post post) async {
    return checkItemFailOrSuccess(remoteDataSource.deletePost(post));
  }
}
