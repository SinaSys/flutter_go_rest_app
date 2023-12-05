import 'package:clean_architecture_rxdart/core/app_string.dart';
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
    switch (statusCode) {
      case 400:
        return AppString.badRequest;
      case 401:
        return AppString.unauthorized;
      case 403:
        return AppString.forbidden;
      case 404:
        return AppString.notFound;
      case 422:
        return AppString.duplicateEmail;
      case 500:
        return AppString.internalServerError;
      case 502:
        return AppString.badGateway;
      default:
        return AppString.unknownError;
    }
  }

  @override
  String toString() => message;
}
