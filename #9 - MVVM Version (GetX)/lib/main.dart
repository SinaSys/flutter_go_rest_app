import 'package:mvvm_getx/di.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_getx/core/app_theme.dart';
import 'package:mvvm_getx/core/app_config.dart';
import 'package:mvvm_getx/core/app_string.dart';
import 'package:mvvm_getx/core/app_style.dart' show logger;
import 'package:mvvm_getx/view/user/screens/user_list_screen.dart';

Future<void> main() async => await initApp();

Future<void> initApp() async {
  await initDi();

  WidgetsFlutterBinding.ensureInitialized();

  const backendStr = String.fromEnvironment(
    'BACKEND',
    defaultValue: AppString.gorestEnv,
  );
  final backend = BackendEnv.fromString(backendStr);

  await ConfigLoader.load(backend);

  logger.i('Running with backend: ${ConfigLoader.currentEnv}');

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
