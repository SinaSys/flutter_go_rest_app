import 'package:rxdart/rxdart.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:clean_architecture_rxdart/common/network/api_result.dart';
import 'package:clean_architecture_rxdart/common/bloc/generic_bloc_state.dart';
import 'package:clean_architecture_rxdart/features/comment/data/models/comment.dart';
import 'package:clean_architecture_rxdart/features/comment/domain/usecases/get_comments_usecase.dart';
import 'package:clean_architecture_rxdart/features/comment/domain/usecases/create_comment_usecase.dart';
import 'package:clean_architecture_rxdart/features/comment/domain/usecases/delete_comment_usecase.dart';

@immutable
class CommentBloc {
  factory CommentBloc({
    getCommentsUseCase,
    createCommentUseCase,
    deleteCommentUseCase,
  }) {
    final BehaviorSubject<int> getComments = BehaviorSubject<int>();

    final BehaviorSubject<Comment> createComment = BehaviorSubject<Comment>();

    final BehaviorSubject<Comment> deleteComment = BehaviorSubject<Comment>();

    final Stream<GenericBlocState<Comment>> comments =
        getComments.switchMap<ApiResult<List<Comment>>>(
      (postId) {
        return Rx.fromCallable(
          () async =>
              await getCommentsUseCase.call(GetCommentsParams(postId: postId)),
        );
      }, // Return Stream<ApiResult<List<Comment>>>
    ).asyncMap<GenericBlocState<Comment>>(
      (result) {
        return result.when(
          success: (List<Comment> items) async {
            if (items.isEmpty) {
              return GenericBlocState.empty();
            } else {
              return GenericBlocState.success(items);
            }
          },
          failure: (String failure) async {
            return GenericBlocState.failure(failure);
          },
        );
      },
    );

    final isCommentCreated = createComment.flatMap((comment) {
      return Rx.fromCallable<ApiResult<bool>>(
        () {
          return createCommentUseCase.call(CreateCommentParams(comment));
        },
      ); // Return Stream<ApiResult<bool>>
    }).asyncMap<GenericBlocState<bool>>(
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

    final Stream<GenericBlocState<bool>> isCommentDeleted =
        deleteComment.flatMap(
      (comment) {
        return Rx.fromCallable<ApiResult<bool>>(
          () async {
            return await deleteCommentUseCase
                .call(DeleteCommentParams(comment));
          },
        ); // Return ApiResult<bool>,
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

    return CommentBloc._(
      getCommentsUseCase: getCommentsUseCase,
      createCommentUseCase: createCommentUseCase,
      deleteCommentUseCase: deleteCommentUseCase,
      createComment: createComment,
      isCommentCreated: isCommentCreated,
      comments: comments,
      deleteComments: deleteComment,
      getComments: getComments,
      isCommentDeleted: isCommentDeleted,
    );
  }

  //Use cases
  final GetCommentsUseCase getCommentsUseCase;
  final CreateCommentUseCase createCommentUseCase;
  final DeleteCommentUseCase deleteCommentUseCase;

  // read-only properties
  final Stream<GenericBlocState<Comment>> comments;
  final Stream<GenericBlocState<bool>> isCommentCreated;
  final Stream<GenericBlocState<bool>> isCommentDeleted;

// write-only properties
  final Sink<int> getComments;
  final Sink<Comment> createComment;
  final Sink<Comment> deleteComments;

  //Private constructor
  const CommentBloc._({
    required this.getCommentsUseCase,
    required this.createCommentUseCase,
    required this.deleteCommentUseCase,
    required this.getComments,
    required this.comments,
    required this.createComment,
    required this.isCommentCreated,
    required this.deleteComments,
    required this.isCommentDeleted,
  });

  void dispose() {
    getComments.close();
    createComment.close();
    deleteComments.close();
  }
}
