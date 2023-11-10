import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:layered_architecture_cubit/core/app_theme.dart';
import 'package:layered_architecture_cubit/features/post/cubit/post_cubit.dart';
import 'package:layered_architecture_cubit/features/todo/cubit/todo_cubit.dart';
import 'package:layered_architecture_cubit/features/user/cubit/user_cubit.dart';
import 'package:layered_architecture_cubit/features/comment/cubit/comment_cubit.dart';
import 'package:layered_architecture_cubit/features/user/view/screen/user_list_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserCubit>(create: (context) => UserCubit()),
        BlocProvider<TodoCubit>(create: (context) => TodoCubit()),
        BlocProvider<PostCubit>(create: (context) => PostCubit()),
        BlocProvider<CommentCubit>(create: (context) => CommentCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightAppTheme,
        home: const UserListScreen(),
      ),
    );
  }
}
