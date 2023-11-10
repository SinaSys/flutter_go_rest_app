import 'package:flutter/material.dart';
import 'package:layered_architecture/core/app_theme.dart';
import 'package:layered_architecture/features/user/view/screen/user_list_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightAppTheme,
      debugShowCheckedModeBanner: false,
      home: const UserListScreen(),
    );
  }
}
