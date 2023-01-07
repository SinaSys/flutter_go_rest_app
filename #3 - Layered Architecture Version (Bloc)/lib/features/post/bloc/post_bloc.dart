import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/post_event.dart';

import '../../../common/bloc/bloc_helper.dart';
import '../../../common/bloc/generic_bloc_state.dart';
import '../data/model/post.dart';
import '../data/provider/remote/post_api.dart';

typedef Emit = Emitter<GenericBlocState<Post>>;

class PostBloc extends Bloc<PostEvent, GenericBlocState<Post>>
    with BlocHelper<Post> {
  PostBloc() : super(GenericBlocState.loading()) {
    on<PostFetched>(getPosts);
    on<PostCreated>(createPost);
    on<PostUpdated>(updatePost);
    on<PostDeleted>(deletePost);
  }

  final PostApi postApi = PostApi();

  String get getPostCount => "${state.data?.length ?? 0}";

  Future<void> getPosts(PostFetched event, Emit emit) async {
    operation = ApiOperation.select;
    await getItems(postApi.getPosts(event.user), emit);
  }

  Future<void> createPost(PostCreated event, Emit emit) async {
    operation = ApiOperation.create;
    await createItem(postApi.createPost(event.post), emit);
  }

  Future<void> updatePost(PostUpdated event, Emit emit) async {
    operation = ApiOperation.update;
    await updateItem(postApi.updatePost(event.post), emit);
  }

  Future<void> deletePost(PostDeleted event, Emit emit) async {
    operation = ApiOperation.delete;
    await deleteItem(postApi.deletePost(event.post), emit);
  }
}
