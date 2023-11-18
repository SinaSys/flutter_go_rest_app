import 'package:flutter/material.dart';
import 'package:clean_architecture_getx/di.dart';
import 'package:clean_architecture_getx/core/app_theme.dart';
import 'package:clean_architecture_getx/features/user/presentation/screens/user_list_screen.dart';

void main() async {
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightAppTheme,
      home: const UserListScreen(),
    );
  }
}
