import 'package:clean_architecture_bloc/features/comment/presentation/bloc/comment_bloc.dart';
import 'package:clean_architecture_bloc/features/post/presentation/bloc/post_bloc.dart';
import 'package:clean_architecture_bloc/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/app/app_theme.dart';
import 'features/user/presentation/bloc/user_bloc.dart';
import 'features/user/presentation/screens/user_list_screen.dart';
import 'di.dart';

void main() async {
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
        useInheritedMediaQuery: true,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightAppTheme,
        home: const UserListScreen(),
      ),
    );
  }
}
