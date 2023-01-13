import 'package:clean_architecture_riverpod/features/comment/provider/comment_provider.dart';
import 'package:clean_architecture_riverpod/features/post/presentation/provider/post_provider.dart';
import 'package:clean_architecture_riverpod/features/todo/presentation/provider/todo_provider.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'common/network/dio_client.dart';
import 'features/comment/data/datasources/comment_remote_data_source.dart';
import 'features/comment/data/repositories/comment_repository_impl.dart';
import 'features/comment/domain/repositories/comment_repository.dart';
import 'features/comment/domain/usecases/create_comment_usecase.dart';
import 'features/comment/domain/usecases/delete_comment_usecase.dart';
import 'features/comment/domain/usecases/get_comments_usecase.dart';
import 'features/comment/presentation/cubit/comment_cubit.dart';
import 'features/post/data/datasources/post_remote_data_source.dart';
import 'features/post/data/repositories/post_repository_impl.dart';
import 'features/post/domain/repositories/post_repository.dart';
import 'features/post/domain/usecases/create_post_usecase.dart';
import 'features/post/domain/usecases/delete_post_usecase.dart';
import 'features/post/domain/usecases/get_posts_usecase.dart';
import 'features/post/domain/usecases/update_post_usecase.dart';
import 'features/post/presentation/cubit/post_cubit.dart';
import 'features/todo/data/datasources/todo_remote_data_source.dart';
import 'features/todo/data/repositories/todo_repository_impl.dart';
import 'features/todo/domain/repositories/todo_repository.dart';
import 'features/todo/domain/usecases/create_todo_usecase.dart';
import 'features/todo/domain/usecases/delete_todo_usecase.dart';
import 'features/todo/domain/usecases/get_todos_usecase.dart';
import 'features/todo/domain/usecases/update_todo_usecase.dart';
import 'features/todo/presentation/cubit/todo_cubit.dart';
import 'features/user/data/datasources/user_remote_data_source.dart';
import 'features/user/data/repositories/user_repository_impl.dart';
import 'features/user/domain/repositories/user_repository.dart';
import 'features/user/domain/usecases/create_user_usecase.dart';
import 'features/user/domain/usecases/delete_user_usecase.dart';
import 'features/user/domain/usecases/get_users_usecase.dart';
import 'features/user/domain/usecases/update_user_usecase.dart';
import 'features/user/presentation/cubit/user_cubit.dart';
import 'features/user/presentation/provider/user_provider.dart';

final getIt = GetIt.instance;

Future<void> init() async {

  //User notifier
  getIt.registerFactory(
    () => UserNotifier(
      getUsersUseCase: getIt<GetUsersUseCase>(),
      createUserUseCase: getIt<CreateUserUseCase>(),
      updateUserUseCase: getIt<UpdateUserUseCase>(),
      deleteUserUseCase: getIt<DeleteUserUseCase>(),
    ),
  );

  //_todo notifier
  getIt.registerFactory(
    () => TodoNotifier(
      getTodoUseCase: getIt<GetTodoUseCase>(),
      createTodoUseCase: getIt<CreateTodoUseCase>(),
      updateTodoUseCase: getIt<UpdateTodoUseCase>(),
      deleteTodoUseCase: getIt<DeleteTodoUseCase>(),
    ),
  );

  //post notifier
  getIt.registerFactory(
    () => PostNotifier(
      getPostsUseCase: getIt(),
      createPostUseCase: getIt(),
      updatePostUseCase: getIt(),
      deletePostUseCase: getIt(),
    ),
  );


  //Comment notifier
  getIt.registerFactory(
    () => CommentNotifier(
      getCommentsUseCase: getIt(),
      createCommentUseCase: getIt(),
      deleteCommentUseCase: getIt(),
    ),
  );

  // User Use cases
  getIt.registerLazySingleton(() => GetUsersUseCase(getIt()));
  getIt.registerLazySingleton(() => CreateUserUseCase(getIt()));
  getIt.registerLazySingleton(() => UpdateUserUseCase(getIt()));
  getIt.registerLazySingleton(() => DeleteUserUseCase(getIt()));

  // _Todo Use cases
  getIt.registerLazySingleton(() => GetTodoUseCase(getIt()));
  getIt.registerLazySingleton(() => CreateTodoUseCase(getIt()));
  getIt.registerLazySingleton(() => UpdateTodoUseCase(getIt()));
  getIt.registerLazySingleton(() => DeleteTodoUseCase(getIt()));

  // Post Use cases
  getIt.registerLazySingleton(() => GetPostsUseCase(getIt()));
  getIt.registerLazySingleton(() => CreatePostUseCase(getIt()));
  getIt.registerLazySingleton(() => UpdatePostUseCase(getIt()));
  getIt.registerLazySingleton(() => DeletePostUseCase(getIt()));

  // Comment Use cases
  getIt.registerLazySingleton(() => GetCommentsUseCase(getIt()));
  getIt.registerLazySingleton(() => CreateCommentUseCase(getIt()));
  getIt.registerLazySingleton(() => DeleteCommentUseCase(getIt()));

  // User repository
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(remoteDataSource: getIt()),
  );

// _Todo repository
  getIt.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(remoteDataSource: getIt()),
  );

  // Post repository
  getIt.registerLazySingleton<PostRepository>(
    () => PostRepositoryImpl(remoteDataSource: getIt()),
  );

  // Comment repository
  getIt.registerLazySingleton<CommentRepository>(
    () => CommentRepositoryImpl(remoteDataSource: getIt()),
  );

  // User remote data sources
  getIt.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl());

  // _Todo remote data sources
  getIt.registerLazySingleton<TodoRemoteDataSource>(
      () => TodoRemoteDataSourceImpl());

  // Post remote data sources
  getIt.registerLazySingleton<PostRemoteDataSource>(
      () => PostRemoteDataSourceImpl());

  // Comment remote data sources
  getIt.registerLazySingleton<CommentRemoteDataSource>(
      () => CommentRemoteDataSourceImpl());

  //Dio
  getIt.registerLazySingleton<DioClient>(() => DioClient(getIt<Dio>()));
  getIt.registerLazySingleton<Dio>(() => Dio());
}
