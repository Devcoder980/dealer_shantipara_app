import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Interceptor to handle API errors
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final errorMessage = _getErrorMessage(err);

    debugPrint('╔══════════════════════════════════════════════════════════');
    debugPrint('║ API ERROR');
    debugPrint('╠══════════════════════════════════════════════════════════');
    debugPrint('║ URL: ${err.requestOptions.uri}');
    debugPrint('║ Method: ${err.requestOptions.method}');
    debugPrint('║ Status Code: ${err.response?.statusCode}');
    debugPrint('║ Error Message: $errorMessage');
    debugPrint('╚══════════════════════════════════════════════════════════');

    // Create custom DioException with parsed error message
    final customError = DioException(
      requestOptions: err.requestOptions,
      response: err.response,
      type: err.type,
      error: errorMessage,
      message: errorMessage,
    );

    handler.next(customError);
  }

  /// Parse error message from response
  String _getErrorMessage(DioException err) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout. Please check your internet connection.';

      case DioExceptionType.sendTimeout:
        return 'Request timeout. Please try again.';

      case DioExceptionType.receiveTimeout:
        return 'Server response timeout. Please try again.';

      case DioExceptionType.badResponse:
        return _parseResponseError(err.response);

      case DioExceptionType.cancel:
        return 'Request was cancelled.';

      case DioExceptionType.connectionError:
        return 'No internet connection. Please check your network.';

      case DioExceptionType.unknown:
      default:
        return err.message ?? 'An unexpected error occurred.';
    }
  }

  /// Parse error message from API response
  String _parseResponseError(Response? response) {
    if (response == null) return 'Unknown server error';

    try {
      final data = response.data;
      if (data is Map<String, dynamic>) {
        // Handle standard error format: { success: false, message: "..." }
        if (data.containsKey('message')) {
          return data['message'] as String;
        }
        // Handle error object: { error: { message: "..." } }
        if (data.containsKey('error')) {
          final error = data['error'];
          if (error is Map<String, dynamic> && error.containsKey('message')) {
            return error['message'] as String;
          }
        }
      }
    } catch (e) {
      debugPrint('Error parsing response: $e');
    }

    // Fallback to HTTP status messages
    switch (response.statusCode) {
      case 400:
        return 'Bad request. Please check your input.';
      case 401:
        return 'Session expired. Please login again.';
      case 403:
        return 'Access denied.';
      case 404:
        return 'Resource not found.';
      case 422:
        return 'Validation error. Please check your input.';
      case 500:
        return 'Server error. Please try again later.';
      default:
        return 'Error: ${response.statusCode}';
    }
  }
}
