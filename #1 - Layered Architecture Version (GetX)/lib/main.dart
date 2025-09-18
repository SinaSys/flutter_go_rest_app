import 'package:flutter/material.dart';
import 'package:layered_architecture/core/app_theme.dart';
import 'package:layered_architecture/core/app_config.dart';
import 'package:layered_architecture/core/app_string.dart';
import 'package:layered_architecture/core/app_style.dart' show logger;
import 'package:layered_architecture/features/user/view/screen/user_list_screen.dart';


Future<void> main() async {
  await initApp();
}

Future<void> initApp() async {
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
      theme: AppTheme.lightAppTheme,
      debugShowCheckedModeBanner: false,
      home: const UserListScreen(),
    );
  }
}
