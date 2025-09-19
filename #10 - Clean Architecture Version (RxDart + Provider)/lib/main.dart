import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clean_architecture_rxdart/di.dart';
import 'package:clean_architecture_rxdart/core/app_theme.dart';
import 'package:clean_architecture_rxdart/core/app_config.dart';
import 'package:clean_architecture_rxdart/core/app_string.dart';
import 'package:clean_architecture_rxdart/core/app_style.dart' show logger;
import 'package:clean_architecture_rxdart/features/post/presentation/bloc/post_bloc.dart';
import 'package:clean_architecture_rxdart/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:clean_architecture_rxdart/features/user/presentation/bloc/user_bloc.dart';
import 'package:clean_architecture_rxdart/features/comment/presentation/bloc/comment_bloc.dart';
import 'package:clean_architecture_rxdart/features/user/presentation/screens/user_list_screen.dart';

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
    return MultiProvider(
      providers: [
        Provider<UserBloc>(create: (context) => getIt<UserBloc>()),
        Provider<TodoBloc>(create: (context) => getIt<TodoBloc>()),
        Provider<PostBloc>(create: (context) => getIt<PostBloc>()),
        Provider<CommentBloc>(create: (context) => getIt<CommentBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightAppTheme,
        home: const UserListScreen(),
      ),
    );
  }
}
