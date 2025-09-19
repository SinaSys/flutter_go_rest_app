import 'dart:convert' show jsonDecode;
import 'package:flutter/services.dart' show rootBundle;
import 'package:clean_architecture_getx/core/app_asset.dart';
import 'package:clean_architecture_getx/core/app_string.dart';

enum BackendEnv {
  gorest(AppAsset.gorestConfig, 'GoRest'),
  spring(AppAsset.springConfig, 'Spring Boot');

  final String assetPath;
  final String displayName;

  const BackendEnv(this.assetPath, this.displayName);

  static BackendEnv fromString(String value) => switch (value) {
        AppString.springEnv => BackendEnv.spring,
        AppString.gorestEnv => BackendEnv.gorest,
        _ => BackendEnv.gorest,
      };

  @override
  String toString() => displayName;
}

class AppConfig {
  final String backendUrl;
  final String? apiKey;
  final BackendEnv env;

  AppConfig({
    required this.backendUrl,
    this.apiKey,
    required this.env,
  });

  factory AppConfig.fromJson(Map<String, dynamic> json, BackendEnv env) {
    return AppConfig(
      backendUrl: json['backend_url'] as String,
      apiKey: json['api_key'] as String?,
      env: env,
    );
  }
}

class ConfigLoader {
  static AppConfig? _instance;

  ConfigLoader._();

  static AppConfig get instance {
    if (_instance == null) {
      throw Exception('AppConfig not loaded yet! Call ConfigLoader.load() first.');
    }
    return _instance!;
  }

  static BackendEnv get currentEnv => instance.env;

  static bool get isGorest => currentEnv == BackendEnv.gorest;

  static bool get isSpring => currentEnv == BackendEnv.spring;

  static Future<AppConfig> load(BackendEnv env) async {
    if (_instance != null && _instance!.env == env) {
      return _instance!;
    }

    try {
      final jsonString = await rootBundle.loadString(env.assetPath);
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      _instance = AppConfig.fromJson(jsonMap, env);
      return _instance!;
    } catch (e) {
      throw Exception('Failed to load configuration for ${env.displayName}: $e');
    }
  }
}
