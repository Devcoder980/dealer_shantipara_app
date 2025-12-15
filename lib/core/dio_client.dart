import 'package:dio/dio.dart';
import 'api_endpoints.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/error_interceptor.dart';
import 'interceptors/logging_interceptor.dart';

/// Singleton Dio client with configured interceptors
class DioClient {
  static Dio? _dio;

  DioClient._();

  /// Get singleton Dio instance
  static Dio get instance {
    _dio ??= _createDio();
    return _dio!;
  }

  /// Create and configure Dio instance
  static Dio _createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // Note: Browser-restricted headers (User-Agent, sec-ch-*, Origin, Referer)
          // are automatically set by the browser and cannot be overridden
        },
      ),
    );

    // Add interceptors in order
    dio.interceptors.addAll([
      AuthInterceptor(),
      ErrorInterceptor(),
      LoggingInterceptor(),
    ]);

    return dio;
  }

  /// Reset Dio instance (useful for logout)
  static void reset() {
    _dio = null;
  }
}
