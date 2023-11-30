import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'create_post_usecase_test.mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../test_utils/data/test_data.dart';
import 'package:clean_architecture_getx/features/post/domain/usecases/delete_post_usecase.dart';

void main() {
  late DeletePostUseCase deletePostUseCase;
  late MockPostRepository mockPostRepository;

  setUp(
    () {
      mockPostRepository = MockPostRepository();
      deletePostUseCase = DeletePostUseCase(mockPostRepository);
    },
  );

  test(
    'Should call deletePost from post repository',
    () async {
      when(mockPostRepository.deletePost(tPostDummyObject)).thenAnswer(
        (_) async => const Right<String, bool>(true),
      );

      final result = await deletePostUseCase.call(const DeletePostParams(tPostDummyObject));

      expect(result, const Right<String, bool>(true));

      verify(mockPostRepository.deletePost(tPostDummyObject));

      verifyNoMoreInteractions(mockPostRepository);
    },
  );
}
