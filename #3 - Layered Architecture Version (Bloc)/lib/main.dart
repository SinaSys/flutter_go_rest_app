import 'package:flutter/material.dart';
import 'package:layered_architecture_bloc/features/comment/bloc/comment_bloc.dart';
import 'package:layered_architecture_bloc/features/post/bloc/post_bloc.dart';
import 'package:layered_architecture_bloc/features/todo/bloc/todo_bloc.dart';
import 'package:layered_architecture_bloc/features/user/bloc/user_bloc.dart';
import 'core/app_theme.dart';
import 'features/user/view/screen/user_list_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(create: (context) => UserBloc()),
        BlocProvider<TodoBloc>(create: (context) => TodoBloc()),
        BlocProvider<PostBloc>(create: (context) => PostBloc()),
        BlocProvider<CommentBloc>(create: (context) => CommentBloc()),
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
