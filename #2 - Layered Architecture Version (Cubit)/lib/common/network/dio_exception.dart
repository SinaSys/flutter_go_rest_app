import 'package:layered_architecture_cubit/core/app_string.dart';
import 'package:dio/dio.dart' show DioException, DioExceptionType;

class DioExceptions implements Exception {
  late String message;

  DioExceptions.fromDioError(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.cancel:
        message = AppString.cancelRequest;
        break;
      case DioExceptionType.connectionTimeout:
        message = AppString.connectionTimeOut;
        break;
      case DioExceptionType.receiveTimeout:
        message = AppString.receiveTimeOut;
        break;
      case DioExceptionType.badResponse:
        message = _handleError(
          dioException.response?.statusCode,
          dioException.response?.data,
        );
        break;
      case DioExceptionType.sendTimeout:
        message = AppString.sendTimeOut;
        break;
      case DioExceptionType.connectionError:
        message = AppString.socketException;
        break;
      default:
        message = AppString.unknownError;
        break;
    }
  }

  String _handleError(int? statusCode, dynamic error) {
    return switch (statusCode) {
      400 => AppString.badRequest,
      401 => AppString.unauthorized,
      403 => AppString.forbidden,
      404 => AppString.notFound,
      422 => AppString.duplicateEmail,
      500 => AppString.internalServerError,
      502 => AppString.badGateway,
      _ => AppString.unknownError
    };
  }

  @override
  String toString() => message;
}
