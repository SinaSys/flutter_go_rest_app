import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'create_post_usecase_test.mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../test_utils/data/test_data.dart';
import 'package:clean_architecture_getx/features/post/data/models/post.dart';
import 'package:clean_architecture_getx/features/post/domain/usecases/get_posts_usecase.dart';

void main() {
  late GetPostsUseCase getPostsUseCase;
  late MockPostRepository mockPostRepository;

  setUp(
    () {
      mockPostRepository = MockPostRepository();
      getPostsUseCase = GetPostsUseCase(mockPostRepository);
    },
  );

  test(
    'Should call getPosts from post repository',
    () async {
      when(mockPostRepository.getPosts(tUserDummyObject)).thenAnswer(
        (_) async => const Right<String, List<Post>>([tPostDummyObject]),
      );

      final result = await getPostsUseCase.call(
        const GetPostsParams(user: tUserDummyObject),
      );

      result.fold(
        (_) {},
        (List<Post> posts) => expect(posts, [tPostDummyObject]),
      );

      verify(mockPostRepository.getPosts(tUserDummyObject));

      verifyNoMoreInteractions(mockPostRepository);
    },
  );
}
