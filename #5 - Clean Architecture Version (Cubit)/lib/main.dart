import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_architecture_cubit/di.dart';
import 'package:clean_architecture_cubit/core/app_theme.dart';
import 'package:clean_architecture_cubit/features/post/presentation/cubit/post_cubit.dart';
import 'package:clean_architecture_cubit/features/todo/presentation/cubit/todo_cubit.dart';
import 'package:clean_architecture_cubit/features/user/presentation/cubit/user_cubit.dart';
import 'package:clean_architecture_cubit/features/comment/presentation/cubit/comment_cubit.dart';
import 'package:clean_architecture_cubit/features/user/presentation/screens/user_list_screen.dart';

void main() async {
  await init();
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
