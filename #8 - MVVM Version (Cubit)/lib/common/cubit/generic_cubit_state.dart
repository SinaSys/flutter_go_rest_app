import 'package:flutter/foundation.dart' show immutable;

enum Status { empty, loading, failure, success }

@immutable
class GenericCubitState<T> {
  final T? data;
  final String? error;
  final Status status;

  const GenericCubitState({this.data, this.error, required this.status});

  factory GenericCubitState.empty() => const GenericCubitState(status: Status.empty);

  factory GenericCubitState.loading() => const GenericCubitState(status: Status.loading);

  factory GenericCubitState.failure(String error) => GenericCubitState(error: error, status: Status.failure);

  factory GenericCubitState.success(T? data) => GenericCubitState(data: data, status: Status.success);
}
