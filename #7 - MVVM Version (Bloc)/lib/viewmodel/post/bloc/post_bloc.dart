import 'package:mvvm_bloc/viewmodel/post/bloc/post_event.dart';
import 'package:mvvm_bloc/repository/post/post_repository.dart';
import 'package:mvvm_bloc/common/bloc/generic_bloc_state.dart';
import 'package:mvvm_bloc/common/bloc/bloc_helper.dart';
import 'package:mvvm_bloc/data/model/post/post.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef Emit = Emitter<GenericBlocState<Post>>;

class PostBloc extends Bloc<PostEvent, GenericBlocState<Post>> with BlocHelper<Post> {
  PostBloc({required this.postRepository}) : super(GenericBlocState.loading()) {
    on<PostFetched>(getPosts);
    on<PostCreated>(createPost);
    on<PostUpdated>(updatePost);
    on<PostDeleted>(deletePost);
  }

  final PostRepository postRepository;

  String get getPostCount => "${state.data?.length ?? 0}";

  Future<void> getPosts(PostFetched event, Emit emit) async {
    await getItems(postRepository.getPosts(event.user), emit);
  }

  Future<void> createPost(PostCreated event, Emit emit) async {
    await createItem(postRepository.createPost(event.post), emit);
  }

  Future<void> updatePost(PostUpdated event, Emit emit) async {
    await updateItem(postRepository.updatePost(event.post), emit);
  }

  Future<void> deletePost(PostDeleted event, Emit emit) async {
    await deleteItem(postRepository.deletePost(event.post), emit);
  }
}
