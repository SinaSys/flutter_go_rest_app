import 'package:mvvm_cubit/viewmodel/comment/cubit/comment_cubit.dart';
import 'package:mvvm_cubit/view/user/screen/user_list_screen.dart';
import 'package:mvvm_cubit/viewmodel/post/cubit/post_cubit.dart';
import 'package:mvvm_cubit/viewmodel/todo/cubit/todo_cubit.dart';
import 'package:mvvm_cubit/viewmodel/user/cubit/user_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm_cubit/core/app_theme.dart';
import 'package:flutter/material.dart';
import 'di.dart';

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
