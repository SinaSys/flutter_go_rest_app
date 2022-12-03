import 'package:flutter/material.dart';
import 'package:layered_architecture_cubit/features/todo/cubit/todo_cubit.dart';
import 'core/app_theme.dart';
import 'features/comment/cubit/comment_cubit.dart';
import 'features/post/cubit/post_cubit.dart';
import 'features/user/cubit/user_cubit.dart';
import 'features/user/view/screen/user_list_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
        useInheritedMediaQuery: true,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightAppTheme,
        home: const UserListScreen(),
      ),
    );
  }
}
