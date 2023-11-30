import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'create_post_usecase_test.mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../test_utils/data/test_data.dart';
import 'package:clean_architecture_getx/features/post/domain/usecases/update_post_usecase.dart';

void main() {
  late UpdatePostUseCase updatePostUseCase;
  late MockPostRepository mockPostRepository;

  setUp(
    () {
      mockPostRepository = MockPostRepository();
      updatePostUseCase = UpdatePostUseCase(mockPostRepository);
    },
  );

  test(
    'Should call updatePost from post repository',
    () async {
      when(mockPostRepository.updatePost(tPostDummyObject)).thenAnswer(
        (_) async => const Right<String, bool>(true),
      );

      final result = await updatePostUseCase.call(const UpdatePostParams(tPostDummyObject));

      expect(result, const Right<String, bool>(true));

      verify(mockPostRepository.updatePost(tPostDummyObject));

      verifyNoMoreInteractions(mockPostRepository);
    },
  );
}
