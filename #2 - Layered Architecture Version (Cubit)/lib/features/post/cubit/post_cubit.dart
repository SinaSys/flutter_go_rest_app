import '../../../common/cubit/generic_cubit.dart';
import '../../user/data/model/user.dart';
import '../data/model/post.dart';
import '../data/provider/remote/post_api.dart';

class PostCubit extends GenericCubit<Post> {
  final PostApi postApi = PostApi();

  String get getPostCount => "${state.data?.length ?? 0}";

  Future<void> getPosts(User user) async {
    getItems(postApi.getPosts(user));
  }

  void createPost(Post post) async {
    createItem(postApi.createPost(post));
  }

  void updatePost(Post post) async {
    updateItem(postApi.updatePost(post));
  }

  void deletePost(Post post) async {
    deleteItem(postApi.deletePost(post));
  }
}
