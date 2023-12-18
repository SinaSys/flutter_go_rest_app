import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'create_comment_usecase_test.mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../test_utils/data/test_data.dart';
import 'package:clean_architecture_getx/features/comment/data/models/comment.dart';
import 'package:clean_architecture_getx/features/comment/domain/usecases/get_comments_usecase.dart';

void main() {
  late GetCommentsUseCase getCommentsUseCase;
  late MockCommentRepository mockCommentRepository;

  setUp(
    () {
      mockCommentRepository = MockCommentRepository();
      getCommentsUseCase = GetCommentsUseCase(mockCommentRepository);
    },
  );

  test(
    'Should call getComments from comment repository',
    () async {
      when(mockCommentRepository.getComments(any)).thenAnswer(
        (_) async => const Right<String, List<Comment>>([tCommentDummyObject]),
      );

      final result = await getCommentsUseCase.call(
        GetCommentsParams(postId: tPostDummyObject.id),
      );

      result.fold(
        (_) {},
        (List<Comment> comments) => expect(comments, [tCommentDummyObject]),
      );

      verify(mockCommentRepository.getComments(tPostDummyObject.id));

      verifyNoMoreInteractions(mockCommentRepository);
    },
  );
}
