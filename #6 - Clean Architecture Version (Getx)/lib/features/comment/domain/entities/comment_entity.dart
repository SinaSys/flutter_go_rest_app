import 'package:flutter/foundation.dart' show immutable;

@immutable
class CommentEntity {
  const CommentEntity({
    required this.id,
    required this.postId,
    required this.name,
    required this.email,
    required this.body,
  });

  final int id;
  final int postId;
  final String name;
  final String email;
  final String body;
}
