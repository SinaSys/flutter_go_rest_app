import 'package:flutter/foundation.dart' show immutable;
import 'package:clean_architecture_rxdart/features/user/domain/entities/user_entity.dart';

@immutable
class UsersFetched {
  final Gender? gender;
  final UserStatus? status;

  const UsersFetched({this.gender, this.status});
}
