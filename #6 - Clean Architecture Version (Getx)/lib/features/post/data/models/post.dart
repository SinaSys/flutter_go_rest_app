import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:clean_architecture_getx/features/post/domain/entities/post_entity.dart';

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

  //For unit testing
  @override
  bool operator ==(Object other) => identical(this, other) || other is Post && runtimeType == other.runtimeType;

  //For unit testing
  @override
  int get hashCode => 0;

  Map<String, dynamic> toJson() => _$PostToJson(this);
}
