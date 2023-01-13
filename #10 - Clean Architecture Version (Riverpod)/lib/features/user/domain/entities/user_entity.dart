import 'package:flutter/foundation.dart' show immutable;

@immutable
class UserEntity {
  const UserEntity({
    this.id,
    required this.name,
    required this.email,
    required this.gender,
    required this.status,
  });

  final int? id;
  final String name;
  final String email;
  final Gender gender;
  final UserStatus status;

  UserEntity copyWith({
    int? id,
    String? name,
    String? email,
    Gender? gender,
    UserStatus? status,
  }) {
    return UserEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      status: status ?? this.status,
    );
  }
}

enum Gender { male, female, all }

enum UserStatus { inactive, active, all }
