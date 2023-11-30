import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'create_post_usecase_test.mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../test_utils/data/test_data.dart';
import 'package:clean_architecture_getx/features/post/domain/repositories/post_repository.dart';
import 'package:clean_architecture_getx/features/post/domain/usecases/create_post_usecase.dart';

@GenerateMocks([PostRepository])
void main() {
  late CreatePostUseCase createPostUseCase;
  late MockPostRepository mockPostRepository;

  setUp(
    () {
      mockPostRepository = MockPostRepository();
      createPostUseCase = CreatePostUseCase(mockPostRepository);
    },
  );

  test(
    'Should call createPost from post repository',
    () async {
      when(mockPostRepository.createPost(tPostDummyObject)).thenAnswer(
        (_) async => const Right<String, bool>(true),
      );

      final result = await createPostUseCase.call(const CreatePostParams(tPostDummyObject));

      expect(result, const Right<String, bool>(true));

      verify(mockPostRepository.createPost(tPostDummyObject));

      verifyNoMoreInteractions(mockPostRepository);
    },
  );
}
