import 'package:layered_architecture/features/user/view/screen/user_list_screen.dart';
import 'package:layered_architecture/core/app_theme.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightAppTheme,
      debugShowCheckedModeBanner: false,
      home: const UserListScreen(),
    );
  }
}
