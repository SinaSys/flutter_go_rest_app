import 'package:clean_architecture_getx/features/user/presentation/screens/user_list_screen.dart';
import 'package:clean_architecture_getx/core/app_theme.dart';
import 'package:clean_architecture_getx/di.dart';
import 'package:flutter/material.dart';

void main() async {
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightAppTheme,
      home: const UserListScreen(),
    );
  }
}
