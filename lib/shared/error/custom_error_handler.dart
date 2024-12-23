import 'package:dio/dio.dart';

class CustomErrorHandler {
  static String handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.cancel:
        return 'Request was cancelled. Please try again.';
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timed out. Please check your internet connection.';
      case DioExceptionType.badResponse:
        final response = error.response;
        if (response != null && response.data is Map<String, dynamic>) {
          return response.data['message'] ?? 'Something went wrong.';
        }
        return 'Unexpected error occurred with status code ${response?.statusCode}.';
      case DioExceptionType.connectionError:
        return 'No internet connection. Please check your network.';
      default:
        return 'Unexpected error occurred. Please try again later.';
    }
  }

  static String handleError(dynamic error) {
    if (error is DioException) {
      return handleDioError(error);
    }
    return 'An unknown error occurred. Please try again later.';
  }
}
