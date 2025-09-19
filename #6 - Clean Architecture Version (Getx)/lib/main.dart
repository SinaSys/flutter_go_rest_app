import 'package:flutter/material.dart';
import 'package:clean_architecture_getx/di.dart';
import 'package:clean_architecture_getx/core/app_theme.dart';
import 'package:clean_architecture_getx/core/app_config.dart';
import 'package:clean_architecture_getx/core/app_style.dart' show logger;
import 'package:clean_architecture_getx/core/app_string.dart' show AppString;
import 'package:clean_architecture_getx/features/user/presentation/screens/user_list_screen.dart';

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
