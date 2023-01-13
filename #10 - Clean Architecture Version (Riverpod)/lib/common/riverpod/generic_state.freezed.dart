// // coverage:ignore-file
// // GENERATED CODE - DO NOT MODIFY BY HAND
// // ignore_for_file: type=lint
// // ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark
//
// part of 'generic_state.dart';
//
// // **************************************************************************
// // FreezedGenerator
// // **************************************************************************
//
// T _$identity<T>(T value) => value;
//
// final _privateConstructorUsedError = UnsupportedError(
//     'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');
//
// /// @nodoc
// mixin _$GenericState<T> {
//   List<T>? get data => throw _privateConstructorUsedError;
//   String? get error => throw _privateConstructorUsedError;
//   Status get status => throw _privateConstructorUsedError;
//   HttpMethod? get httpMethod => throw _privateConstructorUsedError;
//
//   @JsonKey(ignore: true)
//   $GenericStateCopyWith<T, GenericState<T>> get copyWith =>
//       throw _privateConstructorUsedError;
// }
//
// /// @nodoc
// abstract class $GenericStateCopyWith<T, $Res> {
//   factory $GenericStateCopyWith(
//           GenericState<T> value, $Res Function(GenericState<T>) then) =
//       _$GenericStateCopyWithImpl<T, $Res, GenericState<T>>;
//   @useResult
//   $Res call(
//       {List<T>? data, String? error, Status status, HttpMethod? httpMethod});
// }
//
// /// @nodoc
// class _$GenericStateCopyWithImpl<T, $Res, $Val extends GenericState<T>>
//     implements $GenericStateCopyWith<T, $Res> {
//   _$GenericStateCopyWithImpl(this._value, this._then);
//
//   // ignore: unused_field
//   final $Val _value;
//   // ignore: unused_field
//   final $Res Function($Val) _then;
//
//   @pragma('vm:prefer-inline')
//   @override
//   $Res call({
//     Object? data = freezed,
//     Object? error = freezed,
//     Object? status = null,
//     Object? httpMethod = freezed,
//   }) {
//     return _then(_value.copyWith(
//       data: freezed == data
//           ? _value.data
//           : data // ignore: cast_nullable_to_non_nullable
//               as List<T>?,
//       error: freezed == error
//           ? _value.error
//           : error // ignore: cast_nullable_to_non_nullable
//               as String?,
//       status: null == status
//           ? _value.status
//           : status // ignore: cast_nullable_to_non_nullable
//               as Status,
//       httpMethod: freezed == httpMethod
//           ? _value.httpMethod
//           : httpMethod // ignore: cast_nullable_to_non_nullable
//               as HttpMethod?,
//     ) as $Val);
//   }
// }
//
// /// @nodoc
// abstract class _$$_GenericStateCopyWith<T, $Res>
//     implements $GenericStateCopyWith<T, $Res> {
//   factory _$$_GenericStateCopyWith(
//           _$_GenericState<T> value, $Res Function(_$_GenericState<T>) then) =
//       __$$_GenericStateCopyWithImpl<T, $Res>;
//   @override
//   @useResult
//   $Res call(
//       {List<T>? data, String? error, Status status, HttpMethod? httpMethod});
// }
//
// /// @nodoc
// class __$$_GenericStateCopyWithImpl<T, $Res>
//     extends _$GenericStateCopyWithImpl<T, $Res, _$_GenericState<T>>
//     implements _$$_GenericStateCopyWith<T, $Res> {
//   __$$_GenericStateCopyWithImpl(
//       _$_GenericState<T> _value, $Res Function(_$_GenericState<T>) _then)
//       : super(_value, _then);
//
//   @pragma('vm:prefer-inline')
//   @override
//   $Res call({
//     Object? data = freezed,
//     Object? error = freezed,
//     Object? status = null,
//     Object? httpMethod = freezed,
//   }) {
//     return _then(_$_GenericState<T>(
//       data: freezed == data
//           ? _value._data
//           : data // ignore: cast_nullable_to_non_nullable
//               as List<T>?,
//       error: freezed == error
//           ? _value.error
//           : error // ignore: cast_nullable_to_non_nullable
//               as String?,
//       status: null == status
//           ? _value.status
//           : status // ignore: cast_nullable_to_non_nullable
//               as Status,
//       httpMethod: freezed == httpMethod
//           ? _value.httpMethod
//           : httpMethod // ignore: cast_nullable_to_non_nullable
//               as HttpMethod?,
//     ));
//   }
// }
//
// /// @nodoc
//
// class _$_GenericState<T> implements _GenericState<T> {
//   const _$_GenericState(
//       {final List<T>? data, this.error, required this.status, this.httpMethod})
//       : _data = data;
//
//   final List<T>? _data;
//   @override
//   List<T>? get data {
//     final value = _data;
//     if (value == null) return null;
//     if (_data is EqualUnmodifiableListView) return _data;
//     // ignore: implicit_dynamic_type
//     return EqualUnmodifiableListView(value);
//   }
//
//   @override
//   final String? error;
//   @override
//   final Status status;
//   @override
//   final HttpMethod? httpMethod;
//
//   @override
//   String toString() {
//     return 'GenericState<$T>(data: $data, error: $error, status: $status, httpMethod: $httpMethod)';
//   }
//
//   @override
//   bool operator ==(dynamic other) {
//     return identical(this, other) ||
//         (other.runtimeType == runtimeType &&
//             other is _$_GenericState<T> &&
//             const DeepCollectionEquality().equals(other._data, _data) &&
//             (identical(other.error, error) || other.error == error) &&
//             (identical(other.status, status) || other.status == status) &&
//             (identical(other.httpMethod, httpMethod) ||
//                 other.httpMethod == httpMethod));
//   }
//
//   @override
//   int get hashCode => Object.hash(runtimeType,
//       const DeepCollectionEquality().hash(_data), error, status, httpMethod);
//
//   @JsonKey(ignore: true)
//   @override
//   @pragma('vm:prefer-inline')
//   _$$_GenericStateCopyWith<T, _$_GenericState<T>> get copyWith =>
//       __$$_GenericStateCopyWithImpl<T, _$_GenericState<T>>(this, _$identity);
// }
//
// abstract class _GenericState<T> implements GenericState<T> {
//   const factory _GenericState(
//       {final List<T>? data,
//       final String? error,
//       required final Status status,
//       final HttpMethod? httpMethod}) = _$_GenericState<T>;
//
//   @override
//   List<T>? get data;
//   @override
//   String? get error;
//   @override
//   Status get status;
//   @override
//   HttpMethod? get httpMethod;
//   @override
//   @JsonKey(ignore: true)
//   _$$_GenericStateCopyWith<T, _$_GenericState<T>> get copyWith =>
//       throw _privateConstructorUsedError;
// }
