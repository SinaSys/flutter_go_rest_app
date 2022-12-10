import 'package:flutter/foundation.dart' show immutable;

@immutable
class PostEntity {
  const PostEntity({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  final int id;
  final int userId;
  final String title;
  final String body;
}
