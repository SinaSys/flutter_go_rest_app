import 'package:clean_architecture_getx/common/network/dio_client.dart';
import 'package:clean_architecture_getx/features/comment/data/datasources/comment_remote_data_source.dart';
import 'package:clean_architecture_getx/features/comment/data/repositories/comment_repository_impl.dart';
import 'package:clean_architecture_getx/features/comment/domain/repositories/comment_repository.dart';
import 'package:clean_architecture_getx/features/comment/presentation/controller/comment_controller.dart';
import 'package:clean_architecture_getx/features/post/data/datasources/post_remote_data_source.dart';
import 'package:clean_architecture_getx/features/post/data/repositories/post_repository_impl.dart';
import 'package:clean_architecture_getx/features/post/domain/repositories/post_repository.dart';
import 'package:clean_architecture_getx/features/post/presentation/controller/post_controller.dart';
import 'package:clean_architecture_getx/features/todo/data/datasources/todo_remote_data_source.dart';
import 'package:clean_architecture_getx/features/todo/data/repositories/todo_repository_impl.dart';
import 'package:clean_architecture_getx/features/todo/domain/repositories/todo_repository.dart';
import 'package:clean_architecture_getx/features/todo/presentation/controller/todo_controller.dart';
import 'package:clean_architecture_getx/features/user/data/datasources/user_remote_data_source.dart';
import 'package:clean_architecture_getx/features/user/data/repositories/user_repository_impl.dart';
import 'package:clean_architecture_getx/features/user/domain/repositories/user_repository.dart';
import 'package:clean_architecture_getx/features/user/domain/usecases/create_user_usecase.dart';
import 'package:clean_architecture_getx/features/user/domain/usecases/delete_user_usecase.dart';
import 'package:clean_architecture_getx/features/user/domain/usecases/get_users_usecase.dart';
import 'package:clean_architecture_getx/features/user/domain/usecases/update_user_usecase.dart';
import 'package:clean_architecture_getx/features/user/presentation/controller/user_controller.dart';
import 'package:clean_architecture_getx/features/todo/domain/usecases/create_todo_usecase.dart';
import 'package:clean_architecture_getx/features/todo/domain/usecases/delete_todo_usecase.dart';
import 'package:clean_architecture_getx/features/todo/domain/usecases/get_todos_usecase.dart';
import 'package:clean_architecture_getx/features/todo/domain/usecases/update_todo_usecase.dart';
import 'package:clean_architecture_getx/features/comment/domain/usecases/create_comment_usecase.dart';
import 'package:clean_architecture_getx/features/comment/domain/usecases/delete_comment_usecase.dart';
import 'package:clean_architecture_getx/features/comment/domain/usecases/get_comments_usecase.dart';
import 'package:clean_architecture_getx/features/post/domain/usecases/create_post_usecase.dart';
import 'package:clean_architecture_getx/features/post/domain/usecases/delete_post_usecase.dart';
import 'package:clean_architecture_getx/features/post/domain/usecases/get_posts_usecase.dart';
import 'package:clean_architecture_getx/features/post/domain/usecases/update_post_usecase.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  //UserController
  getIt.registerFactory(
    () => UserController(
      getUsersUseCase: getIt<GetUsersUseCase>(),
      createUserUseCase: getIt<CreateUserUseCase>(),
      updateUserUseCase: getIt<UpdateUserUseCase>(),
      deleteUserUseCase: getIt<DeleteUserUseCase>(),
    ),
  );

  //TodoController
  getIt.registerFactory(
    () => ToDoController(
      getTodoUseCase: getIt<GetTodoUseCase>(),
      createTodoUseCase: getIt<CreateTodoUseCase>(),
      updateTodoUseCase: getIt<UpdateTodoUseCase>(),
      deleteTodoUseCase: getIt<DeleteTodoUseCase>(),
    ),
  );

  //PostController
  getIt.registerFactory(
    () => PostController(
      getPostsUseCase: getIt<GetPostsUseCase>(),
      createPostUseCase: getIt<CreatePostUseCase>(),
      updatePostUseCase: getIt<UpdatePostUseCase>(),
      deletePostUseCase: getIt<DeletePostUseCase>(),
    ),
  );
  //
  // //CommentController
  getIt.registerFactory(
    () => CommentController(
      getCommentsUseCase: getIt<GetCommentsUseCase>(),
      createCommentUseCase: getIt<CreateCommentUseCase>(),
      deleteCommentUseCase: getIt<DeleteCommentUseCase>(),
    ),
  );

  // User Use cases
  getIt.registerLazySingleton(() => GetUsersUseCase(getIt<UserRepository>()));
  getIt.registerLazySingleton(() => CreateUserUseCase(getIt<UserRepository>()));
  getIt.registerLazySingleton(() => UpdateUserUseCase(getIt<UserRepository>()));
  getIt.registerLazySingleton(() => DeleteUserUseCase(getIt<UserRepository>()));

  // _Todo Use cases
  getIt.registerLazySingleton(() => GetTodoUseCase(getIt<TodoRepository>()));
  getIt.registerLazySingleton(() => CreateTodoUseCase(getIt<TodoRepository>()));
  getIt.registerLazySingleton(() => UpdateTodoUseCase(getIt<TodoRepository>()));
  getIt.registerLazySingleton(() => DeleteTodoUseCase(getIt<TodoRepository>()));

  // Post Use cases
  getIt.registerLazySingleton(() => GetPostsUseCase(getIt<PostRepository>()));
  getIt.registerLazySingleton(() => CreatePostUseCase(getIt<PostRepository>()));
  getIt.registerLazySingleton(() => UpdatePostUseCase(getIt<PostRepository>()));
  getIt.registerLazySingleton(() => DeletePostUseCase(getIt<PostRepository>()));

  // Comment Use cases
  getIt.registerLazySingleton(() => GetCommentsUseCase(getIt<CommentRepository>()));
  getIt.registerLazySingleton(() => CreateCommentUseCase(getIt<CommentRepository>()));
  getIt.registerLazySingleton(() => DeleteCommentUseCase(getIt<CommentRepository>()));

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
    () => UserRemoteDataSourceImpl(dioClient: getIt<DioClient>()),
  );

  // _Todo remote data sources
  getIt.registerLazySingleton<TodoRemoteDataSource>(
    () => TodoRemoteDataSourceImpl(dioClient: getIt<DioClient>()),
  );

  // Post remote data sources
  getIt.registerLazySingleton<PostRemoteDataSource>(
    () => PostRemoteDataSourceImpl(dioClient: getIt<DioClient>()),
  );

  // Comment remote data sources
  getIt.registerLazySingleton<CommentRemoteDataSource>(
    () => CommentRemoteDataSourceImpl(dioClient: getIt<DioClient>()),
  );

  //Dio
  getIt.registerLazySingleton<DioClient>(() => DioClient(getIt<Dio>()));
  getIt.registerLazySingleton<Dio>(() => Dio());
}
