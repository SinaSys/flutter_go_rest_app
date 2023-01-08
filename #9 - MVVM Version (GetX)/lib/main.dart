import 'package:flutter/material.dart';
import 'view/user/screens/user_list_screen.dart';

import 'core/app_theme.dart';
import 'di.dart';

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
