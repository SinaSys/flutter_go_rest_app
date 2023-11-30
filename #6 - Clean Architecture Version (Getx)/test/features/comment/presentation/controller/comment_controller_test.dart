import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'comment_controller_test.mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../test_utils/data/test_data.dart';
import 'package:clean_architecture_getx/common/controller/base_controller.dart';
import 'package:clean_architecture_getx/features/comment/data/models/comment.dart';
import 'package:clean_architecture_getx/features/comment/domain/usecases/get_comments_usecase.dart';
import 'package:clean_architecture_getx/features/comment/domain/usecases/create_comment_usecase.dart';
import 'package:clean_architecture_getx/features/comment/domain/usecases/delete_comment_usecase.dart';
import 'package:clean_architecture_getx/features/comment/presentation/controller/comment_controller.dart';

@GenerateMocks([
  GetCommentsUseCase,
  CreateCommentUseCase,
  DeleteCommentUseCase,
])
void main() {
  late CommentController commentController;
  late MockGetCommentsUseCase mockGetCommentsUseCase;
  late MockCreateCommentUseCase mockCreateCommentUseCase;
  late MockDeleteCommentUseCase mockDeleteCommentUseCase;

  setUp(
    () {
      mockCreateCommentUseCase = MockCreateCommentUseCase();
      mockDeleteCommentUseCase = MockDeleteCommentUseCase();
      mockGetCommentsUseCase = MockGetCommentsUseCase();
      commentController = CommentController(
        getCommentsUseCase: mockGetCommentsUseCase,
        createCommentUseCase: mockCreateCommentUseCase,
        deleteCommentUseCase: mockDeleteCommentUseCase,
      );
    },
  );

  group(
    'All test cases related to the createComment',
    () {
      test(
        'should emit [success] when data is gotten successfully',
        () async {
          expect(commentController.apiStatus.value, ApiState.loading);

          when(mockCreateCommentUseCase.call(any)).thenAnswer((_) async => const Right(true));

          await commentController.createComment(tCommentDummyObject);

          expect(commentController.apiStatus.value, ApiState.success);
        },
      );

      test(
        'should emit [failure] when data is not gotten successfully',
        () async {
          expect(commentController.apiStatus.value, ApiState.loading);

          when(mockCreateCommentUseCase.call(any)).thenAnswer((_) async => const Left(tDummyExceptionMsg));

          await commentController.createComment(tCommentDummyObject);

          expect(commentController.apiStatus.value, ApiState.failure);

          expect(commentController.errorMessage.value, tDummyExceptionMsg);
        },
      );
    },
  );

  group(
    'All test cases related to the deleteComment',
    () {
      test(
        'should emit [success] when data is gotten successfully',
        () async {
          expect(commentController.apiStatus.value, ApiState.loading);

          when(mockDeleteCommentUseCase.call(any)).thenAnswer((_) async => const Right(true));

          await commentController.deleteComment(tCommentDummyObject);

          expect(commentController.apiStatus.value, ApiState.success);
        },
      );

      test(
        'should emit [failure] when data is not gotten successfully',
        () async {
          expect(commentController.apiStatus.value, ApiState.loading);

          when(mockDeleteCommentUseCase.call(any)).thenAnswer((_) async => const Left(tDummyExceptionMsg));

          await commentController.deleteComment(tCommentDummyObject);

          expect(commentController.apiStatus.value, ApiState.failure);

          expect(commentController.errorMessage.value, tDummyExceptionMsg);
        },
      );
    },
  );

  group(
    'All test cases related to the getUserComments',
    () {
      test(
        'should get list of Comments when data is gotten successfully',
        () async {
          when(mockGetCommentsUseCase.call(any)).thenAnswer((_) async => const Right([tCommentDummyObject]));

          await commentController.getUserComments(tPostDummyObject.id);

          commentController.failureOrSuccess?.fold(
            (_) {},
            (List<Comment> comments) {
              expect(comments, [tCommentDummyObject]);
            },
          );
        },
      );

      test(
        'should get error message when data is not gotten successfully',
        () async {
          when(mockGetCommentsUseCase.call(any)).thenAnswer((_) async => const Left(tDummyExceptionMsg));

          await commentController.getUserComments(tPostDummyObject.id);

          commentController.failureOrSuccess?.fold(
            (String error) => expect(error, tDummyExceptionMsg),
            (_) {},
          );

          expect(commentController.failureOrSuccess?.isLeft(), true);
        },
      );
    },
  );
}
