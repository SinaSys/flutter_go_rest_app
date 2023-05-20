import 'package:dio/dio.dart';
import 'dart:io' show SocketException;
import 'package:dio/dio.dart' show DioError, DioErrorType;
import 'package:clean_architecture_rxdart/core/app_string.dart';

class DioExceptions implements Exception {
  late String message;

  DioExceptions.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        message = AppString.cancelRequest;
        break;
      case DioErrorType.connectionTimeout:
        message = AppString.connectionTimeOut;
        break;
      case DioErrorType.receiveTimeout:
        message = AppString.receiveTimeOut;
        break;
      case DioErrorType.badResponse:
        message = _handleError(
          dioError.response?.statusCode,
          dioError.response?.data,
        );
        break;
      case DioErrorType.sendTimeout:
        message = AppString.sendTimeOut;
        break;
      case DioErrorType.unknown:
        if (dioError.error is SocketException) {
          message = AppString.socketException;
          break;
        }
        message = AppString.unexpectedError;
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
