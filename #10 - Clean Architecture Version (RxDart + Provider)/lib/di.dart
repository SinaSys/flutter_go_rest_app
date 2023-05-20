import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:clean_architecture_rxdart/common/network/dio_client.dart';
import 'package:clean_architecture_rxdart/features/comment/data/datasources/comment_remote_data_source.dart';
import 'package:clean_architecture_rxdart/features/comment/data/repositories/comment_repository_impl.dart';
import 'package:clean_architecture_rxdart/features/comment/domain/repositories/comment_repository.dart';
import 'package:clean_architecture_rxdart/features/comment/domain/usecases/create_comment_usecase.dart';
import 'package:clean_architecture_rxdart/features/comment/domain/usecases/delete_comment_usecase.dart';
import 'package:clean_architecture_rxdart/features/comment/domain/usecases/get_comments_usecase.dart';
import 'package:clean_architecture_rxdart/features/comment/presentation/bloc/comment_bloc.dart';
import 'package:clean_architecture_rxdart/features/post/data/datasources/post_remote_data_source.dart';
import 'package:clean_architecture_rxdart/features/post/data/repositories/post_repository_impl.dart';
import 'package:clean_architecture_rxdart/features/post/domain/repositories/post_repository.dart';
import 'package:clean_architecture_rxdart/features/post/domain/usecases/create_post_usecase.dart';
import 'package:clean_architecture_rxdart/features/post/domain/usecases/delete_post_usecase.dart';
import 'package:clean_architecture_rxdart/features/post/domain/usecases/get_posts_usecase.dart';
import 'package:clean_architecture_rxdart/features/post/domain/usecases/update_post_usecase.dart';
import 'package:clean_architecture_rxdart/features/post/presentation/bloc/post_bloc.dart';
import 'package:clean_architecture_rxdart/features/todo/data/datasources/todo_remote_data_source.dart';
import 'package:clean_architecture_rxdart/features/todo/data/repositories/todo_repository_impl.dart';
import 'package:clean_architecture_rxdart/features/todo/domain/repositories/todo_repository.dart';
import 'package:clean_architecture_rxdart/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:clean_architecture_rxdart/features/user/data/datasources/user_remote_data_source.dart';
import 'package:clean_architecture_rxdart/features/user/data/repositories/user_repository_impl.dart';
import 'package:clean_architecture_rxdart/features/user/domain/repositories/user_repository.dart';
import 'package:clean_architecture_rxdart/features/user/domain/usecases/create_user_usecase.dart';
import 'package:clean_architecture_rxdart/features/user/domain/usecases/delete_user_usecase.dart';
import 'package:clean_architecture_rxdart/features/user/domain/usecases/get_users_usecase.dart';
import 'package:clean_architecture_rxdart/features/user/domain/usecases/update_user_usecase.dart';
import 'package:clean_architecture_rxdart/features/user/presentation/bloc/user_bloc.dart';
import 'package:clean_architecture_rxdart/features/todo/domain/usecases/create_todo_usecase.dart';
import 'package:clean_architecture_rxdart/features/todo/domain/usecases/delete_todo_usecase.dart';
import 'package:clean_architecture_rxdart/features/todo/domain/usecases/get_todos_usecase.dart';
import 'package:clean_architecture_rxdart/features/todo/domain/usecases/update_todo_usecase.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  //UserBloc
  getIt.registerFactory(
    () => UserBloc(
      getUsersUseCase: getIt<GetUsersUseCase>(),
      createUserUseCase: getIt<CreateUserUseCase>(),
      updateUserUseCase: getIt<UpdateUserUseCase>(),
      deleteUserUseCase: getIt<DeleteUserUseCase>(),
    ),
  );

  //TodoBloc
  getIt.registerFactory(
    () => TodoBloc(
      getTodoUseCase: getIt<GetTodoUseCase>(),
      createTodoUseCase: getIt<CreateTodoUseCase>(),
      updateTodoUseCase: getIt<UpdateTodoUseCase>(),
      deleteTodoUseCase: getIt<DeleteTodoUseCase>(),
    ),
  );

  //PostBloc
  getIt.registerFactory(
    () => PostBloc(
      getPostsUseCase: getIt<GetPostsUseCase>(),
      createPostUseCase: getIt<CreatePostUseCase>(),
      updatePostUseCase: getIt<UpdatePostUseCase>(),
      deletePostUseCase: getIt<DeletePostUseCase>(),
    ),
  );

  //CommentBloc
  getIt.registerFactory(
    () => CommentBloc(
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
  getIt.registerLazySingleton(
      () => GetCommentsUseCase(getIt<CommentRepository>()));
  getIt.registerLazySingleton(
      () => CreateCommentUseCase(getIt<CommentRepository>()));
  getIt.registerLazySingleton(
      () => DeleteCommentUseCase(getIt<CommentRepository>()));

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
