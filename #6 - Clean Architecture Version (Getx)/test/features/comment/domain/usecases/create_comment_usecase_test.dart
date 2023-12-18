import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'create_comment_usecase_test.mocks.dart';
import '../../../../test_utils/data/test_data.dart';
import 'package:clean_architecture_getx/features/comment/domain/usecases/create_comment_usecase.dart';
import 'package:clean_architecture_getx/features/comment/domain/repositories/comment_repository.dart';

@GenerateMocks([CommentRepository])
void main() {
  late CreateCommentUseCase createCommentUseCase;
  late MockCommentRepository mockCommentRepository;

  setUp(
    () {
      mockCommentRepository = MockCommentRepository();
      createCommentUseCase = CreateCommentUseCase(mockCommentRepository);
    },
  );

  test(
    'Should call createComment from comment repository',
    () async {
      when(mockCommentRepository.createComment(tCommentDummyObject)).thenAnswer(
        (_) async => const Right<String, bool>(true),
      );

      final result = await createCommentUseCase.call(const CreateCommentParams(tCommentDummyObject));

      expect(result, const Right<String, bool>(true));

      verify(mockCommentRepository.createComment(tCommentDummyObject));

      verifyNoMoreInteractions(mockCommentRepository);
    },
  );
}
