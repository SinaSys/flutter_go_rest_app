import 'package:flutter/foundation.dart' show immutable;

///The base state class should always be named: BlocSubject + State.

enum Status { empty, loading, failure, success }

@immutable
class GenericBlocState<T> {
  final List<T>? data;
  final String? error;
  final Status status;

  const GenericBlocState({this.data, this.error, required this.status});

  factory GenericBlocState.empty() =>
      const GenericBlocState(status: Status.empty);

  factory GenericBlocState.loading() =>
      const GenericBlocState(status: Status.loading);

  factory GenericBlocState.failure(String error) =>
      GenericBlocState(error: error, status: Status.failure);

  factory GenericBlocState.success(List<T>? data) =>
      GenericBlocState(data: data, status: Status.success);
}
