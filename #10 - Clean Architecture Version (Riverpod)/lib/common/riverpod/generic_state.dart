
// import 'package:freezed_annotation/freezed_annotation.dart';
//
//
// part 'generic_state.freezed.dart';
//
// enum HttpMethod { get, post, put, delete }
//
// enum Status { empty, loading, failure, success }
//
// @freezed
// class GenericState<T> with _$GenericState<T> {
//   const factory GenericState({
//     List<T>? data,
//     String? error,
//     required Status status,
//     HttpMethod? httpMethod,
//   }) = _GenericState<T>;
// }
//
//
//



// import 'package:flutter/foundation.dart' show immutable;
//
// import 'generic_provider.dart';
//
// enum HttpMethod { get, post, put, delete }
//
// @immutable
// class GenericState<T> {
//   final T? data;
//   final String? error;
//   final Status status;
//   final HttpMethod? httpMethod;
//
//   const GenericState({this.data, this.error, required this.status, this.httpMethod});
//
//   factory GenericState.empty() => const GenericState(status: Status.empty);
//
//   factory GenericState.loading() => const GenericState(status: Status.loading);
//
//   factory GenericState.failure(String error) => GenericState(error: error, status: Status.failure);
//
//   factory GenericState.success(T? data) => GenericState(data: data, status: Status.success);
//
//   GenericState<T> copyWith({
//     T? data,
//     String? error,
//     Status? status,
//     HttpMethod? httpMethod,
//   }) {
//     return GenericState(
//       data: data ?? this.data,
//       error: error ?? this.error,
//       status: status ?? this.status,
//       httpMethod: httpMethod ?? this.httpMethod,
//     );
//   }
// }


// import 'package:flutter/foundation.dart' show immutable;
//
// import 'generic_provider.dart';
//
// enum HttpMethod { get, post, put, delete }
//
// @freezed
// class GenericState<T> with _$GenericState<T> {
//   const factory GenericState({
//     List<T>? data,
//     String? error,
//     Status status,
//     HttpMethod? httpMethod,
//   }) = GenericState<T>;
//
// ;
// }
//
// @immutable

enum HttpMethod { get, post, put, delete }

enum Status { empty, loading, failure, success }

class GenericState<T> {
  final List<T>? data;
  final String? error;
  final Status status;
  final HttpMethod? httpMethod;

  const GenericState(
      {this.data, this.error, required this.status, this.httpMethod});

  factory GenericState.empty() => const GenericState(status: Status.empty);

  factory GenericState.loading() => const GenericState(status: Status.loading);

  factory GenericState.failure(String error) => GenericState(error: error, status: Status.failure);

  factory GenericState.success(List<T>? data) => GenericState(data: data, status: Status.success);

  GenericState<T> copyWith({
    List<T>? data,
    String? error,
    Status? status,
    HttpMethod? httpMethod,
  }) {
    return GenericState<T>(
      data: data  ?? this.data,
      error: error ?? this.error,
      status: status ?? this.status,
      httpMethod: httpMethod ?? this.httpMethod,
    );
  }
}
// //
//   // factory GenericState.empty() => const GenericState(status: Status.empty);
//   //
//   // factory GenericState.loading() => const GenericState(status: Status.loading);
//   //
//   // factory GenericState.failure(String error) => GenericState(error: error, status: Status.failure);
//   //
//   // factory GenericState.success(List<T>? data) => GenericState(data: data, status: Status.success);
//
//
//
//
// }
