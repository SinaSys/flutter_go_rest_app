import 'package:clean_architecture_getx/features/comment/domain/entities/comment_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/foundation.dart' show immutable;

part 'comment.g.dart';

@immutable
@JsonSerializable()
class Comment extends CommentEntity {
  const Comment({
    required super.id,
    @JsonKey(name: "post_id") required super.postId,
    required super.name,
    required super.email,
    required super.body,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);

  //For unit testing
  @override
  bool operator ==(Object other) => identical(this, other) || other is Comment && runtimeType == other.runtimeType;

  //For unit testing
  @override
  int get hashCode => 0;

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
