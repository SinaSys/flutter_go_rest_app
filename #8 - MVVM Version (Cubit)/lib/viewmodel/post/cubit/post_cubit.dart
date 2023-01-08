import '../../../common/cubit/generic_cubit.dart';
import '../../../data/model/post/post.dart';
import '../../../data/model/user/user.dart';
import '../../../repository/post/post_repository.dart';

class PostCubit extends GenericCubit<Post> {
  final PostRepository postRepository;

  PostCubit({required this.postRepository});

  String get getPostCount => "${state.data?.length ?? 0}";

  Future<void> getPosts(User user) async {
    getItems(postRepository.getPosts(user));
  }

  void createPost(Post post) async {
    createItem(postRepository.createPost(post));
  }

  void updatePost(Post post) async {
    updateItem(postRepository.updatePost(post));
  }

  void deletePost(Post post) async {
    deleteItem(postRepository.deletePost(post));
  }
}
