import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/bloc/bloc_helper.dart';
import '../../../common/bloc/generic_bloc_state.dart';
import '../../../data/model/comment/comment.dart';
import '../../../repository/comment/comment_repository.dart';
import 'comment_event.dart';

typedef Emit = Emitter<GenericBlocState<Comment>>;

class CommentBloc extends Bloc<CommentEvent, GenericBlocState<Comment>>
    with BlocHelper<Comment> {
  CommentBloc({required this.commentRepository})
      : super(GenericBlocState.loading()) {
    on<CommentFetched>(getComments);
    on<CommentCreated>(createComment);
    on<CommentDeleted>(deleteComment);
  }

  final CommentRepository commentRepository;

  Future<void> getComments(CommentFetched event, Emit emit) async {
    operation = ApiOperation.select;
    await getItems(commentRepository.getComments(event.postId), emit);
  }

  Future<void> createComment(CommentCreated event, Emit emit) async {
    operation = ApiOperation.create;
    await createItem(commentRepository.createComment(event.comment), emit);
  }

  Future<void> deleteComment(CommentDeleted event, Emit emit) async {
    operation = ApiOperation.delete;
    await deleteItem(commentRepository.deleteComment(event.comment), emit);
  }
}
