import 'package:layered_architecture_cubit/common/cubit/generic_cubit.dart';
import 'package:layered_architecture_cubit/features/post/data/provider/remote/post_api.dart';

import '../../user/data/model/user.dart';
import '../data/model/post.dart';

class PostCubit extends GenericCubit<Post> {
  final PostApi _postApi = PostApi();

  String get getPostCount => "${state.data?.length ?? 0}";

  Future<void> getPosts(User user) async {
    getItems(_postApi.getPosts(user));
  }

  void createPost(Post post) async {
    createItem(_postApi.createPost(post));
  }

  void updatePost(Post post) async {
    updateItem(_postApi.updatePost(post));
  }

  void deletePost(Post post) async {
    deleteItem(_postApi.deletePost(post));
  }
}
