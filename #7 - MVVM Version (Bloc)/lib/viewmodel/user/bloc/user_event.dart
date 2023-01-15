import 'package:mvvm_bloc/data/model/user/user.dart';

/// Events should be named in the past tense because events are things
/// that have already occurred from the bloc's perspective.

abstract class UserEvent {}

class UsersFetched extends UserEvent {
  final Gender? gender;
  final UserStatus? status;

  UsersFetched({this.gender, this.status});
}

class UserCreated extends UserEvent {
  final User user;

  UserCreated(this.user);
}

class UserUpdated extends UserEvent {
  final User user;

  UserUpdated(this.user);
}

class UserDeleted extends UserEvent {
  final User user;

  UserDeleted(this.user);
}
