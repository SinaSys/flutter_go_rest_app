import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'create_comment_usecase_test.mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../test_utils/data/test_data.dart';
import 'package:clean_architecture_getx/features/comment/domain/usecases/delete_comment_usecase.dart';

void main() {
  late DeleteCommentUseCase deleteCommentUseCase;
  late MockCommentRepository mockCommentRepository;

  setUp(
    () {
      mockCommentRepository = MockCommentRepository();
      deleteCommentUseCase = DeleteCommentUseCase(mockCommentRepository);
    },
  );

  test(
    'Should call deleteComment from comment repository',
    () async {
      when(mockCommentRepository.deleteComment(tCommentDummyObject)).thenAnswer(
        (_) async => const Right<String, bool>(true),
      );

      final result = await deleteCommentUseCase.call(const DeleteCommentParams(tCommentDummyObject));

      expect(result, const Right<String, bool>(true));

      verify(mockCommentRepository.deleteComment(tCommentDummyObject));

      verifyNoMoreInteractions(mockCommentRepository);
    },
  );
}
