import 'package:clean_architecture_cubit/features/post/domain/entities/post_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/foundation.dart' show immutable;

part 'post.g.dart';

@immutable
@JsonSerializable()
class Post extends PostEntity {
  const Post({
    required super.id,
    @JsonKey(name: 'user_id') required super.userId,
    required super.title,
    required super.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}
