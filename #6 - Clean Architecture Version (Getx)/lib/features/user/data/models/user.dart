import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:clean_architecture_getx/features/user/domain/entities/user_entity.dart';

part 'user.g.dart';

@immutable
@JsonSerializable()
class User extends UserEntity {
  const User({
    super.id,
    required super.name,
    required super.email,
    required super.gender,
    @JsonKey(name: "status") required super.status,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  ///For unit testing
  @override
  bool operator ==(Object other) => identical(this, other) || other is User && runtimeType == other.runtimeType;

  ///For unit testing
  @override
  int get hashCode => 0;

  ///For unit testing
  User copyWith({
    int? id,
    String? name,
    String? email,
    Gender? gender,
    UserStatus? status,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      status: status ?? this.status,
    );
  }
}
