import 'package:mvvm_cubit/repository/post/post_repository.dart';
import 'package:mvvm_cubit/common/cubit/generic_cubit.dart';
import 'package:mvvm_cubit/data/model/post/post.dart';
import 'package:mvvm_cubit/data/model/user/user.dart';

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
