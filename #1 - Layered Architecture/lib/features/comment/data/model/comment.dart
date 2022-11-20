import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

import 'package:flutter/foundation.dart' show immutable;

part 'comment.g.dart';

List<Comment> commentFromJson(String str) =>
    List<Comment>.from(json.decode(str).map((x) => Comment.fromJson(x)));

String commentToJson(List<Comment> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@immutable
@JsonSerializable()
class Comment {
  const Comment({
    required this.id,
    required this.postId,
    required this.name,
    required this.email,
    required this.body,
  });

  final int id;
  @JsonKey(name: "post_id")
  final int postId;
  final String name;
  final String email;
  final String body;

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);

  @override
  String toString() {
    return 'Comment{id: $id, postId: $postId, name: $name, email: $email, body: $body}';
  }
}
