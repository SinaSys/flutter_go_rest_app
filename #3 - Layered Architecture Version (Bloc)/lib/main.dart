import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:layered_architecture_bloc/core/app_theme.dart';
import 'package:layered_architecture_bloc/features/post/bloc/post_bloc.dart';
import 'package:layered_architecture_bloc/features/todo/bloc/todo_bloc.dart';
import 'package:layered_architecture_bloc/features/user/bloc/user_bloc.dart';
import 'package:layered_architecture_bloc/features/comment/bloc/comment_bloc.dart';
import 'package:layered_architecture_bloc/features/user/view/screen/user_list_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightAppTheme,
        home: const UserListScreen(),
      ),
    );
  }
}
