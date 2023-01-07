import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/app/app_theme.dart';
import 'features/comment/presentation/cubit/comment_cubit.dart';
import 'features/post/presentation/cubit/post_cubit.dart';
import 'features/todo/presentation/cubit/todo_cubit.dart';
import 'features/user/presentation/cubit/user_cubit.dart';
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
        BlocProvider<UserCubit>(create: (context) => getIt<UserCubit>()),
        BlocProvider<TodoCubit>(create: (context) => getIt<TodoCubit>()),
        BlocProvider<PostCubit>(create: (context) => getIt<PostCubit>()),
        BlocProvider<CommentCubit>(create: (context) => getIt<CommentCubit>()),
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
