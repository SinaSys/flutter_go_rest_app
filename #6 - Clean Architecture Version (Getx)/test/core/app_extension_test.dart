import 'package:flutter_test/flutter_test.dart';
import 'package:clean_architecture_getx/core/app_asset.dart';
import 'package:clean_architecture_getx/core/app_extension.dart';

enum TEnum { member1, member2 }

void main() {
  group(
    'String extension',
    () {
      test(
        'Should return {AppAsset.male}',
        () {
          const String maleString = 'male';
          expect(maleString.getGenderWidget, AppAsset.male);
        },
      );

      test(
        'Should return {AppAsset.female}',
        () {
          const String string = 'anythingElse';
          expect(string.getGenderWidget, AppAsset.female);
        },
      );

      test(
        'Should capitalize string',
        () {
          const String str = 'word';
          expect(str.toCapital, 'Word');
        },
      );
    },
  );

  group(
    'Integer extension',
    () {
      test(
        'should return true if value is equal to 200, 201 or 204',
        () {
          int? responseInteger = 200;
          expect(responseInteger.success, true);
        },
      );

      test(
        'should return false if value is not equal to 200, 201 or 204',
        () {
          int? responseInteger = 500;
          expect(responseInteger.success, false);
        },
      );
    },
  );

  group(
    'GeneralExtension',
    () {
      test(
        'should return true if value is a type of enum',
        () {
          expect(TEnum.member1.isEnum, true);
        },
      );

      test(
        'should return false if value is not a type of enum',
        () {
          expect('stringPart1.StringPart2'.isEnum, false);
        },
      );

      test(
        'Should capitalize and return second part of string',
        () {
          String str = "gender.male";
          expect(str.getEnumString, 'Male');
        },
      );
    },
  );

  group(
    'IterableExtension',
    () {
      test(
        'description',
        () {
          List<int> intList = [1, 2, 3];
          List<(int, int)> res = intList.mapWithIndex((index, value) => (index + 1, value * 10)).toList();
          expect(res, <(int, int)>[(1, 10), (2, 20), (3, 30)]);
        },
      );
    },
  );

  group(
    'MapExtension',
    () {
      test(
        'Format map to path parameter string',
        () {
          Map<String, String> map = <String, String>{"gender": "female"};
          expect(map.format, '?gender=female');
        },
      );
    },
  );
}
