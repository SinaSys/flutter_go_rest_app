import 'package:rxdart/rxdart.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:clean_architecture_rxdart/common/network/api_result.dart';
import 'package:clean_architecture_rxdart/common/bloc/generic_bloc_state.dart';
import 'package:clean_architecture_rxdart/features/post/data/models/post.dart';
import 'package:clean_architecture_rxdart/features/user/data/models/user.dart';
import 'package:clean_architecture_rxdart/features/post/domain/usecases/get_posts_usecase.dart';
import 'package:clean_architecture_rxdart/features/post/domain/usecases/create_post_usecase.dart';
import 'package:clean_architecture_rxdart/features/post/domain/usecases/delete_post_usecase.dart';
import 'package:clean_architecture_rxdart/features/post/domain/usecases/update_post_usecase.dart';

@immutable
class PostBloc {
  factory PostBloc({
    required getPostsUseCase,
    required createPostUseCase,
    required updatePostUseCase,
    required deletePostUseCase,
  }) {
    final BehaviorSubject<User> getPostList = BehaviorSubject<User>();

    final BehaviorSubject<int> getPostCount = BehaviorSubject<int>();

    final BehaviorSubject<Post> deletePost = BehaviorSubject<Post>();

    final BehaviorSubject<Post> updatePost = BehaviorSubject<Post>();

    final BehaviorSubject<Post> createPost = BehaviorSubject<Post>();

    final Stream<GenericBlocState<Post>> postList =
        getPostList.switchMap<ApiResult<List<Post>>>(
      (user) {
        return Rx.fromCallable(
          () async => await getPostsUseCase.call(GetPostsParams(user: user)),
        );
      }, // Return Stream<ApiResult<List<Post>>
    ).asyncMap<GenericBlocState<Post>>(
      (result) {
        return result.when(
          success: (List<Post> items) async {
            if (items.isEmpty) {
              return GenericBlocState.empty();
            } else {
              getPostCount.sink.add(items.length);
              return GenericBlocState.success(items);
            }
          },
          failure: (String failure) async {
            return GenericBlocState.failure(failure);
          },
        );
      },
    );

    final Stream<GenericBlocState<bool>> isPostDeleted = deletePost.flatMap(
      (post) {
        return Rx.fromCallable<ApiResult<bool>>(
          () async {
            return await deletePostUseCase.call(DeletePostParams(post));
          },
        ); // Return Stream<ApiResult<bool>>
      },
    ).asyncMap<GenericBlocState<bool>>(
      (result) {
        return result.when(
          success: (_) async {
            return GenericBlocState.success(null);
          },
          failure: (String failure) async {
            return GenericBlocState.failure(failure);
          },
        );
      },
    );

    var isPostUpdated = updatePost.flatMap(
      (post) {
        return Rx.fromCallable<ApiResult<bool>>(
          () async {
            return await updatePostUseCase.call(UpdatePostParams(post));
          },
        );
      },
    ).asyncMap<GenericBlocState<bool>>(
      (result) {
        return result.when(
          success: (_) async {
            return GenericBlocState.success(null);
          },
          failure: (String failure) async {
            return GenericBlocState.failure(failure);
          },
        );
      },
    );

    final isPostCreated = createPost.flatMap(
      (post) {
        return Rx.fromCallable<ApiResult<bool>>(
          () {
            return createPostUseCase.call(CreatePostParams(post));
          },
        ); // Return Stream<ApiResult<bool>>
      },
    ).asyncMap<GenericBlocState<bool>>(
      (result) {
        return result.when(
          success: (_) async {
            return GenericBlocState.success(null);
          },
          failure: (String failure) async {
            return GenericBlocState.failure(failure);
          },
        );
      },
    );

    return PostBloc._(
      getPostsUseCase: getPostsUseCase,
      createPostUseCase: createPostUseCase,
      updatePostUseCase: updatePostUseCase,
      deletePostUseCase: deletePostUseCase,
      getPostList: getPostList,
      postList: postList,
      deletePost: deletePost,
      isPostDeleted: isPostDeleted,
      updatePost: updatePost,
      isPostUpdated: isPostUpdated,
      createPost: createPost,
      isPostCreated: isPostCreated,
      getPostCount: getPostCount,
    );
  }

  //Use cases
  final GetPostsUseCase getPostsUseCase;
  final CreatePostUseCase createPostUseCase;
  final UpdatePostUseCase updatePostUseCase;
  final DeletePostUseCase deletePostUseCase;

  // read-only properties
  final Stream<GenericBlocState<Post>> postList;
  final Stream<GenericBlocState<bool>> isPostDeleted;
  final Stream<GenericBlocState<bool>> isPostUpdated;
  final Stream<GenericBlocState<bool>> isPostCreated;
  final Stream<int> getPostCount;

// write-only properties
  final Sink<User> getPostList;
  final Sink<Post> deletePost;
  final Sink<Post> updatePost;
  final Sink<Post> createPost;

  //Private constructor
  const PostBloc._({
    required this.getPostsUseCase,
    required this.createPostUseCase,
    required this.updatePostUseCase,
    required this.deletePostUseCase,
    required this.postList,
    required this.getPostList,
    required this.deletePost,
    required this.isPostDeleted,
    required this.updatePost,
    required this.isPostUpdated,
    required this.createPost,
    required this.isPostCreated,
    required this.getPostCount,
  });

  void dispose() {
    createPost.close();
    updatePost.close();
    deletePost.close();
    getPostList.close();
  }
}
