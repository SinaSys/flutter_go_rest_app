import 'package:layered_architecture_cubit/core/app_config.dart' show ConfigLoader;

class ApiConfig {
  ApiConfig._();

  static const token = "6369de3d8da8e764cc3c1cbe4121bb6741875de2c30dfd39df8fd351b6a508ea";
  static final String baseUrl = ConfigLoader.instance.backendUrl;
  static const Duration receiveTimeout = Duration(milliseconds: 15000);
  static const Duration connectionTimeout = Duration(milliseconds: 15000);
  static const String users = '/users';
  static const String posts = '/posts';
  static const String comments = '/comments';
  static const String todos = '/todos';

  static Map<String, dynamic> get headers {
    final apiKey = ConfigLoader.instance.apiKey;
    final headers = <String, dynamic>{
      'Content-Type': 'application/json',
    };
    if (apiKey != null && apiKey.isNotEmpty) {
      headers['Authorization'] = 'Bearer $apiKey';
    }
    return headers;
  }
}
