import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'post_controller_test.mocks.dart';
import 'package:mockito/annotations.dart';
import '../../../../test_utils/data/test_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:clean_architecture_getx/common/controller/base_controller.dart';
import 'package:clean_architecture_getx/features/post/data/models/post.dart';
import 'package:clean_architecture_getx/features/post/domain/usecases/get_posts_usecase.dart';
import 'package:clean_architecture_getx/features/post/domain/usecases/create_post_usecase.dart';
import 'package:clean_architecture_getx/features/post/domain/usecases/delete_post_usecase.dart';
import 'package:clean_architecture_getx/features/post/domain/usecases/update_post_usecase.dart';
import 'package:clean_architecture_getx/features/post/presentation/controller/post_controller.dart';

@GenerateMocks([
  GetPostsUseCase,
  CreatePostUseCase,
  UpdatePostUseCase,
  DeletePostUseCase,
  PostController,
])
void main() {
  late PostController postController;
  late MockGetPostsUseCase mockGetPostsUseCase;
  late MockCreatePostUseCase mockCreatePostUseCase;
  late MockUpdatePostUseCase mockUpdatePostUseCase;
  late MockDeletePostUseCase mockDeletePostUseCase;

  setUp(
    () {
      mockGetPostsUseCase = MockGetPostsUseCase();
      mockCreatePostUseCase = MockCreatePostUseCase();
      mockDeletePostUseCase = MockDeletePostUseCase();
      mockUpdatePostUseCase = MockUpdatePostUseCase();
      postController = PostController(
        getPostsUseCase: mockGetPostsUseCase,
        createPostUseCase: mockCreatePostUseCase,
        updatePostUseCase: mockUpdatePostUseCase,
        deletePostUseCase: mockDeletePostUseCase,
      );
    },
  );

  group(
    'All test cases related to the CreatePost',
    () {
      test(
        'should emit [success] when data is gotten successfully',
        () async {
          expect(postController.apiStatus.value, ApiState.loading);

          when(mockCreatePostUseCase.call(any)).thenAnswer((_) async => const Right(true));

          await postController.createPost(tPostDummyObject);

          expect(postController.apiStatus.value, ApiState.success);
        },
      );

      test(
        'should emit [failure] when data is not gotten successfully',
        () async {
          expect(postController.apiStatus.value, ApiState.loading);

          when(mockCreatePostUseCase.call(any)).thenAnswer((_) async => const Left(tDummyExceptionMsg));

          await postController.createPost(tPostDummyObject);

          expect(postController.apiStatus.value, ApiState.failure);

          expect(postController.errorMessage.value, tDummyExceptionMsg);
        },
      );
    },
  );

  group(
    'All test cases related to the updatePost',
    () {
      test(
        'should emit [success] when data is gotten successfully',
        () async {
          expect(postController.apiStatus.value, ApiState.loading);

          when(mockUpdatePostUseCase.call(any)).thenAnswer((_) async => const Right(true));

          await postController.updatePost(tPostDummyObject);

          expect(postController.apiStatus.value, ApiState.success);
        },
      );

      test(
        'should emit [failure] when data is not gotten successfully',
        () async {
          expect(postController.apiStatus.value, ApiState.loading);

          when(mockUpdatePostUseCase.call(any)).thenAnswer((_) async => const Left(tDummyExceptionMsg));

          await postController.updatePost(tPostDummyObject);

          expect(postController.apiStatus.value, ApiState.failure);

          expect(postController.errorMessage.value, tDummyExceptionMsg);
        },
      );
    },
  );

  group(
    'All test cases related to the deletePost',
    () {
      test(
        'should emit [success] when data is gotten successfully',
        () async {
          expect(postController.apiStatus.value, ApiState.loading);

          when(mockDeletePostUseCase.call(any)).thenAnswer((_) async => const Right(true));

          await postController.deletePost(tPostDummyObject);

          expect(postController.apiStatus.value, ApiState.success);
        },
      );

      test(
        'should emit [failure] when data is not gotten successfully',
        () async {
          expect(postController.apiStatus.value, ApiState.loading);

          when(mockDeletePostUseCase.call(any)).thenAnswer((_) async => const Left(tDummyExceptionMsg));

          await postController.deletePost(tPostDummyObject);

          expect(postController.apiStatus.value, ApiState.failure);

          expect(postController.errorMessage.value, tDummyExceptionMsg);
        },
      );
    },
  );

  group(
    'All test cases related to the getPosts',
    () {
      test(
        'should get list of posts when data is gotten successfully',
        () async {
          when(mockGetPostsUseCase.call(any)).thenAnswer((_) async => const Right([tPostDummyObject]));

          await postController.getPosts(tUserDummyObject);

          postController.failureOrSuccess.fold(
            (_) {},
            (List<Post> post) => expect(post, [tPostDummyObject]),
          );
          expect(postController.postLength.value, equals(1));
        },
      );

      test(
        'should get error message when data is not gotten successfully',
        () async {
          when(mockGetPostsUseCase.call(any)).thenAnswer((_) async => const Left(tDummyExceptionMsg));

          await postController.getPosts(tUserDummyObject);

          postController.failureOrSuccess.fold(
            (String error) => expect(error, tDummyExceptionMsg),
            (_) {},
          );

          expect(postController.failureOrSuccess.isLeft(), true);
        },
      );
    },
  );
}
