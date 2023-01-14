import 'package:layered_architecture_bloc/features/comment/data/provider/remote/comment_api.dart';
import 'package:layered_architecture_bloc/features/comment/bloc/comment_event.dart';
import 'package:layered_architecture_bloc/features/comment/data/model/comment.dart';
import 'package:layered_architecture_bloc/common/bloc/generic_bloc_state.dart';
import 'package:layered_architecture_bloc/common/bloc/bloc_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef Emit = Emitter<GenericBlocState<Comment>>;

class CommentBloc extends Bloc<CommentEvent, GenericBlocState<Comment>> with BlocHelper<Comment> {
  CommentBloc() : super(GenericBlocState.loading()) {
    on<CommentFetched>(getComments);
    on<CommentCreated>(createComment);
    on<CommentDeleted>(deleteComment);
  }

  final CommentApi commentApi = CommentApi();

  Future<void> getComments(CommentFetched event, Emit emit) async {
    await getItems(commentApi.getUserComments(event.postId), emit);
  }

  Future<void> createComment(CommentCreated event, Emit emit) async {
    await createItem(commentApi.createComment(event.comment), emit);
  }

  Future<void> deleteComment(CommentDeleted event, Emit emit) async {
    await deleteItem(commentApi.deleteComment(event.comment), emit);
  }
}
