import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import '../../test_utils/data/test_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:clean_architecture_getx/core/app_string.dart';
import 'package:clean_architecture_getx/features/user/data/models/user.dart';
import 'package:clean_architecture_getx/common/repository/repository_helper.dart';

class MockRepositoryHelper<T> with RepositoryHelper<T> {}

void main() {
  late MockRepositoryHelper<User> mockRepositoryHelper;

  setUp(
    () {
      mockRepositoryHelper = MockRepositoryHelper<User>();
    },
  );

  group(
    'All test cases related to the checkItemFailOrSuccess method',
    () {
      test(
        'should return Right(true) if true value is passed',
        () async {
          Either<String, bool> result = await mockRepositoryHelper.checkItemFailOrSuccess(
            Future.value(true),
          );

          expect(result, const Right(true));
        },
      );

      test(
        'should return Left(error) if dio exception occurred',
        () async {
          Either<String, bool> result = await mockRepositoryHelper.checkItemFailOrSuccess(
            Future.error(
              DioException(
                requestOptions: RequestOptions(),
                type: DioExceptionType.cancel,
              ),
            ),
          );

          expect(result, const Left(AppString.cancelRequest));
        },
      );
    },
  );

  group(
    'All test cases related to the checkItemsFailOrSuccess method',
    () {
      test(
        'should return Right(true) if true value is passed',
        () async {
          Either<String, List<User>> result = await mockRepositoryHelper.checkItemsFailOrSuccess(
            Future.value(<User>[tUserDummyObject]),
          );

          result.fold(
            (fail) => {},
            (success) => expect(success, <User>[tUserDummyObject]),
          );
        },
      );

      test(
        'should return Left(error) if dio exception occurred',
        () async {
          Either<String, List> result = await mockRepositoryHelper.checkItemsFailOrSuccess(
            Future.error(
              DioException(
                requestOptions: RequestOptions(),
                type: DioExceptionType.cancel,
              ),
            ),
          );

          expect(result, const Left(AppString.cancelRequest));
        },
      );
    },
  );
}
