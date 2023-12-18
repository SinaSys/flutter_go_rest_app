import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:clean_architecture_getx/core/app_string.dart';
import 'package:clean_architecture_getx/common/network/dio_exception.dart';

void main() {
  test(
    'cancelRequest',
    () {
      expect(
        DioExceptions.fromDioError(
          DioException(
            requestOptions: RequestOptions(),
            type: DioExceptionType.cancel,
          ),
        ).message,
        AppString.cancelRequest,
      );
    },
  );

  test(
    'connectionTimeout',
    () {
      expect(
        DioExceptions.fromDioError(
          DioException(
            requestOptions: RequestOptions(),
            type: DioExceptionType.connectionTimeout,
          ),
        ).message,
        AppString.connectionTimeOut,
      );
    },
  );

  test(
    'receiveTimeOut',
    () {
      expect(
        DioExceptions.fromDioError(
          DioException(
            requestOptions: RequestOptions(),
            type: DioExceptionType.receiveTimeout,
          ),
        ).message,
        AppString.receiveTimeOut,
      );
    },
  );

  test(
    'sendTimeout',
    () {
      expect(
        DioExceptions.fromDioError(
          DioException(
            requestOptions: RequestOptions(),
            type: DioExceptionType.sendTimeout,
          ),
        ).message,
        AppString.sendTimeOut,
      );
    },
  );

  test(
    'SocketException',
    () {
      expect(
        DioExceptions.fromDioError(
          DioException(
            requestOptions: RequestOptions(),
            type: DioExceptionType.connectionError,
            // error: SocketException
          ),
        ).message,
        AppString.socketException,
      );
    },
  );

  test(
    'unknownError',
    () {
      expect(
        DioExceptions.fromDioError(
          DioException(
            requestOptions: RequestOptions(),
            type: DioExceptionType.unknown,
            // error: SocketException
          ),
        ).message,
        AppString.unknownError,
      );
    },
  );

  group(
    'badResponse',
    () {
      test(
        'badRequest',
        () {
          Response response = Response(requestOptions: RequestOptions(), statusCode: 400);

          expect(
            DioExceptions.fromDioError(
              DioException(
                requestOptions: RequestOptions(),
                response: response,
                type: DioExceptionType.badResponse,
              ),
            ).message,
            AppString.badRequest,
          );
        },
      );

      test(
        'unauthorized',
        () {
          Response response = Response(requestOptions: RequestOptions(), statusCode: 401);

          expect(
            DioExceptions.fromDioError(
              DioException(
                requestOptions: RequestOptions(),
                response: response,
                type: DioExceptionType.badResponse,
              ),
            ).message,
            AppString.unauthorized,
          );
        },
      );

      test(
        'forbidden',
        () {
          Response response = Response(requestOptions: RequestOptions(), statusCode: 403);

          expect(
            DioExceptions.fromDioError(
              DioException(
                requestOptions: RequestOptions(),
                response: response,
                type: DioExceptionType.badResponse,
              ),
            ).message,
            AppString.forbidden,
          );
        },
      );

      test(
        'notFound',
        () {
          Response response = Response(requestOptions: RequestOptions(), statusCode: 404);

          expect(
            DioExceptions.fromDioError(
              DioException(
                requestOptions: RequestOptions(),
                response: response,
                type: DioExceptionType.badResponse,
              ),
            ).message,
            AppString.notFound,
          );
        },
      );

      test(
        'duplicateEmail',
        () {
          Response response = Response(requestOptions: RequestOptions(), statusCode: 422);

          expect(
            DioExceptions.fromDioError(
              DioException(
                requestOptions: RequestOptions(),
                response: response,
                type: DioExceptionType.badResponse,
              ),
            ).message,
            AppString.duplicateEmail,
          );
        },
      );

      test(
        'internalServerError',
        () {
          Response response = Response(requestOptions: RequestOptions(), statusCode: 500);

          expect(
            DioExceptions.fromDioError(
              DioException(
                requestOptions: RequestOptions(),
                response: response,
                type: DioExceptionType.badResponse,
              ),
            ).message,
            AppString.internalServerError,
          );
        },
      );

      test(
        'badGateway',
        () {
          Response response = Response(requestOptions: RequestOptions(), statusCode: 502);

          expect(
            DioExceptions.fromDioError(
              DioException(
                requestOptions: RequestOptions(),
                response: response,
                type: DioExceptionType.badResponse,
              ),
            ).message,
            AppString.badGateway,
          );
        },
      );

      test(
        'unknownError for bad response',
        () {
          Response response = Response(requestOptions: RequestOptions(), statusCode: 510);

          expect(
            DioExceptions.fromDioError(
              DioException(
                requestOptions: RequestOptions(),
                response: response,
                type: DioExceptionType.badResponse,
              ),
            ).message,
            AppString.unknownError,
          );
        },
      );
    },
  );
}
