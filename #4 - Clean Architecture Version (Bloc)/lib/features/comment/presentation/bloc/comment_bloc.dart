import 'package:clean_architecture_bloc/common/bloc/bloc_helper.dart';
import 'package:clean_architecture_bloc/common/bloc/generic_bloc_state.dart';
import 'package:clean_architecture_bloc/features/comment/data/models/comment.dart';
import 'package:clean_architecture_bloc/features/comment/domain/usecases/create_comment_usecase.dart';
import 'package:clean_architecture_bloc/features/comment/domain/usecases/delete_comment_usecase.dart';
import 'package:clean_architecture_bloc/features/comment/domain/usecases/get_comments_usecase.dart';
import 'package:clean_architecture_bloc/features/comment/presentation/bloc/comment_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef Emit = Emitter<GenericBlocState<Comment>>;

class CommentBloc extends Bloc<CommentEvent, GenericBlocState<Comment>> with BlocHelper<Comment> {
  CommentBloc({
    required this.getCommentsUseCase,
    required this.createCommentUseCase,
    required this.deleteCommentUseCase,
  }) : super(GenericBlocState.loading()) {
    on<CommentFetched>(getComments);
    on<CommentCreated>(createComment);
    on<CommentDeleted>(deleteComment);
  }

  final GetCommentsUseCase getCommentsUseCase;
  final CreateCommentUseCase createCommentUseCase;
  final DeleteCommentUseCase deleteCommentUseCase;

  Future<void> getComments(CommentFetched event, Emit emit) async {
    await getItems(getCommentsUseCase.call(GetCommentsParams(postId: event.postId)), emit);
  }

  Future<void> createComment(CommentCreated event, Emit emit) async {
    await createItem(createCommentUseCase.call(CreateCommentParams(event.comment)), emit);
  }

  Future<void> deleteComment(CommentDeleted event, Emit emit) async {
    await deleteItem(deleteCommentUseCase.call(DeleteCommentParams(event.comment)), emit);
  }
}
