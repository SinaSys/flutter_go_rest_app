import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_architecture_cubit/di.dart';
import 'package:clean_architecture_cubit/core/app_theme.dart';
import 'package:clean_architecture_cubit/core/app_config.dart';
import 'package:clean_architecture_cubit/core/app_string.dart';
import 'package:clean_architecture_cubit/core/app_style.dart' show logger;
import 'package:clean_architecture_cubit/features/post/presentation/cubit/post_cubit.dart';
import 'package:clean_architecture_cubit/features/todo/presentation/cubit/todo_cubit.dart';
import 'package:clean_architecture_cubit/features/user/presentation/cubit/user_cubit.dart';
import 'package:clean_architecture_cubit/features/comment/presentation/cubit/comment_cubit.dart';
import 'package:clean_architecture_cubit/features/user/presentation/screens/user_list_screen.dart';

Future<void> main() async => await initApp();

Future<void> initApp() async {
  await initDi();

  WidgetsFlutterBinding.ensureInitialized();

  const backendStr = String.fromEnvironment(
    'BACKEND',
    defaultValue: AppString.gorestEnv,
  );
  final backend = BackendEnv.fromString(backendStr);

  await ConfigLoader.load(backend);

  logger.i('Running with backend: ${ConfigLoader.currentEnv}');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserCubit>(create: (context) => getIt<UserCubit>()),
        BlocProvider<TodoCubit>(create: (context) => getIt<TodoCubit>()),
        BlocProvider<PostCubit>(create: (context) => getIt<PostCubit>()),
        BlocProvider<CommentCubit>(create: (context) => getIt<CommentCubit>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightAppTheme,
        home: const UserListScreen(),
      ),
    );
  }
}
