// import '../../../../common/cubit/generic_cubit.dart';
// import '../../data/models/comment.dart';
// import '../../domain/usecases/create_comment_usecase.dart';
// import '../../domain/usecases/delete_comment_usecase.dart';
// import '../../domain/usecases/get_comments_usecase.dart';
//
// class CommentCubit extends GenericCubit<Comment> {
//   final GetCommentsUseCase getCommentsUseCase;
//   final CreateCommentUseCase createCommentUseCase;
//   final DeleteCommentUseCase deleteCommentUseCase;
//
//   CommentCubit({
//     required this.getCommentsUseCase,
//     required this.createCommentUseCase,
//     required this.deleteCommentUseCase,
//   });
//
//   Future<void> getUserComments(int postId) async {
//     getItems(getCommentsUseCase.call(GetCommentsParams(postId: postId)));
//   }
//
//   void createComment(Comment comment) async {
//     createItem(createCommentUseCase.call(CreateCommentParams(comment)));
//   }
//
//   void deleteComment(Comment comment) async {
//     deleteItem(deleteCommentUseCase.call(DeleteCommentParams(comment)));
//   }
// }
