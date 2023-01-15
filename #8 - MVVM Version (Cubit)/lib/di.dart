import 'package:mvvm_cubit/repository/comment/comment_repository.dart';
import 'package:mvvm_cubit/viewmodel/comment/cubit/comment_cubit.dart';
import 'package:mvvm_cubit/repository/todo/todo_repository.dart';
import 'package:mvvm_cubit/repository/user/user_repository.dart';
import 'package:mvvm_cubit/viewmodel/post/cubit/post_cubit.dart';
import 'package:mvvm_cubit/viewmodel/todo/cubit/todo_cubit.dart';
import 'package:mvvm_cubit/viewmodel/user/cubit/user_cubit.dart';
import 'package:mvvm_cubit/data/api/comment/comment_api.dart';
import 'package:mvvm_cubit/repository/post/post_repository.dart';
import 'package:mvvm_cubit/common/network/dio_client.dart';
import 'package:mvvm_cubit/data/api/post/post_api.dart';
import 'package:mvvm_cubit/data/api/todo/todo_api.dart';
import 'package:mvvm_cubit/data/api/user/user_api.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  //Dio
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<DioClient>(() => DioClient(getIt<Dio>()));

  // User api
  getIt.registerLazySingleton<UserApi>(
      () => UserApi(dioClient: getIt<DioClient>()));

  // _Todo api
  getIt.registerLazySingleton<ToDoApi>(
      () => ToDoApi(dioClient: getIt<DioClient>()));

  // Post api
  getIt.registerLazySingleton<PostApi>(
      () => PostApi(dioClient: getIt<DioClient>()));

  // Comment api
  getIt.registerLazySingleton<CommentApi>(
      () => CommentApi(dioClient: getIt<DioClient>()));

  // User repository
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepository(userApi: getIt<UserApi>()),
  );

// _Todo repository
  getIt.registerLazySingleton<TodoRepository>(
    () => TodoRepository(todoApi: getIt<ToDoApi>()),
  );

  // Post repository
  getIt.registerLazySingleton<PostRepository>(
    () => PostRepository(postApi: getIt<PostApi>()),
  );
  // Comment repository
  getIt.registerLazySingleton<CommentRepository>(
    () => CommentRepository(commentApi: getIt<CommentApi>()),
  );

  //User Bloc
  getIt.registerFactory(() => UserCubit(userRepository: getIt<UserRepository>()));

  //_Todo Bloc
  getIt.registerFactory(() => TodoCubit(todoRepository: getIt<TodoRepository>()));

  //Post Bloc
  getIt.registerFactory(() => PostCubit(postRepository: getIt<PostRepository>()));

  //Comment Bloc
  getIt.registerFactory(() => CommentCubit(commentRepository: getIt<CommentRepository>()));
}
