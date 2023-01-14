import 'package:clean_architecture_bloc/common/bloc/bloc_helper.dart';
import 'package:clean_architecture_bloc/common/bloc/generic_bloc_state.dart';
import 'package:clean_architecture_bloc/features/post/data/models/post.dart';
import 'package:clean_architecture_bloc/features/post/domain/usecases/create_post_usecase.dart';
import 'package:clean_architecture_bloc/features/post/domain/usecases/delete_post_usecase.dart';
import 'package:clean_architecture_bloc/features/post/domain/usecases/get_posts_usecase.dart';
import 'package:clean_architecture_bloc/features/post/domain/usecases/update_post_usecase.dart';
import 'package:clean_architecture_bloc/features/post/presentation/bloc/post_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef Emit = Emitter<GenericBlocState<Post>>;

class PostBloc extends Bloc<PostEvent, GenericBlocState<Post>> with BlocHelper<Post> {
  PostBloc({
    required this.getPostsUseCase,
    required this.createPostUseCase,
    required this.updatePostUseCase,
    required this.deletePostUseCase,
  }) : super(GenericBlocState.loading()) {
    on<PostFetched>(getPosts);
    on<PostCreated>(createPost);
    on<PostUpdated>(updatePost);
    on<PostDeleted>(deletePost);
  }

  final GetPostsUseCase getPostsUseCase;
  final CreatePostUseCase createPostUseCase;
  final UpdatePostUseCase updatePostUseCase;
  final DeletePostUseCase deletePostUseCase;

  String get getPostCount => "${state.data?.length ?? 0}";

  Future<void> getPosts(PostFetched event, Emit emit) async {
    await getItems(getPostsUseCase.call(GetPostsParams(user: event.user)), emit);
  }

  Future<void> createPost(PostCreated event, Emit emit) async {
    await createItem(createPostUseCase.call(CreatePostParams(event.post)), emit);
  }

  Future<void> updatePost(PostUpdated event, Emit emit) async {
    await updateItem(updatePostUseCase.call(UpdatePostParams(event.post)), emit);
  }

  Future<void> deletePost(PostDeleted event, Emit emit) async {
    await deleteItem(deletePostUseCase.call(DeletePostParams(event.post)), emit);
  }
}
