import 'package:clean_architecture_cubit/features/post/domain/usecases/create_post_usecase.dart';
import 'package:clean_architecture_cubit/features/post/domain/usecases/delete_post_usecase.dart';
import 'package:clean_architecture_cubit/features/post/domain/usecases/update_post_usecase.dart';
import 'package:clean_architecture_cubit/features/post/domain/usecases/get_posts_usecase.dart';
import 'package:clean_architecture_cubit/features/post/data/models/post.dart';
import 'package:clean_architecture_cubit/features/user/data/models/user.dart';
import 'package:clean_architecture_cubit/common/cubit/generic_cubit.dart';

class PostCubit extends GenericCubit<Post> {
  PostCubit({
    required this.getPostsUseCase,
    required this.createPostUseCase,
    required this.updatePostUseCase,
    required this.deletePostUseCase,
  });

  final GetPostsUseCase getPostsUseCase;
  final CreatePostUseCase createPostUseCase;
  final UpdatePostUseCase updatePostUseCase;
  final DeletePostUseCase deletePostUseCase;

  String get getPostCount => "${state.data?.length ?? 0}";

  Future<void> getPosts(User user) async {
    getItems(getPostsUseCase.call(GetPostsParams(user: user)));
  }

  void createPost(Post post) async {
    createItem(createPostUseCase.call(CreatePostParams(post)));
  }

  void updatePost(Post post) async {
    updateItem(updatePostUseCase.call(UpdatePostParams(post)));
  }

  void deletePost(Post post) async {
    deleteItem(deletePostUseCase.call(DeletePostParams(post)));
  }
}
