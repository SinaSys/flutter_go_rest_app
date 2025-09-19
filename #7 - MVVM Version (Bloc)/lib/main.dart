import 'core/app_theme.dart';
import 'package:mvvm_bloc/di.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_bloc/core/app_config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm_bloc/core/app_string.dart';
import 'package:mvvm_bloc/core/app_style.dart' show logger;
import 'package:mvvm_bloc/viewmodel/post/bloc/post_bloc.dart';
import 'package:mvvm_bloc/viewmodel/todo/bloc/todo_bloc.dart';
import 'package:mvvm_bloc/viewmodel/user/bloc/user_bloc.dart';
import 'package:mvvm_bloc/view/user/screen/user_list_screen.dart';
import 'package:mvvm_bloc/viewmodel/comment/bloc/comment_bloc.dart';

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
        BlocProvider<UserBloc>(create: (context) => getIt<UserBloc>()),
        BlocProvider<TodoBloc>(create: (context) => getIt<TodoBloc>()),
        BlocProvider<PostBloc>(create: (context) => getIt<PostBloc>()),
        BlocProvider<CommentBloc>(create: (context) => getIt<CommentBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightAppTheme,
        home: const UserListScreen(),
      ),
    );
  }
}
