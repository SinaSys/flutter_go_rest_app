import 'package:flutter/material.dart';
import 'package:layered_architecture/core/app_asset.dart';

extension StringExtension on String {
  String get getGenderWidget {
    if (this == "male") return AppAsset.male;
    return AppAsset.female;
  }

  String get toCapital => "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
}

extension IntegetExtension on int? {
  bool get success {
    if (this == 200 || this == 201 || this == 204) {
      return true;
    }
    return false;
  }
}

extension GeneralExtension<T> on T {
  bool get isEnum {
    final split = toString().split('.');
    return split.length > 1 && split[0] == runtimeType.toString();
  }

  String get getEnumString {
    return toString().split('.').last.toCapital;
  }
}

extension IterableExtension<T> on Iterable<T> {
  Iterable<E> mapWithIndex<E>(E Function(int index, T value) f) {
    return Iterable.generate(length).map((i) => f(i, elementAt(i)));
  }
}

extension MapExtension on Map {
  String get format {
    if (isEmpty) return "";

    // map each entry to "key=value" and join them with "&"
    final formatted = entries.map((e) => "${e.key}=${e.value}").join("&");
    return "?$formatted";
  }
}

//Helper functions
void pop(BuildContext context, int returnedLevel) {
  for (var i = 0; i < returnedLevel; ++i) {
    Navigator.pop(context, true);
  }
}
