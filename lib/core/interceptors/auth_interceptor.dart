import 'package:dio/dio.dart';
import '../../utils/hive_config.dart';

/// Interceptor to add authentication token to requests
class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Skip auth header for public endpoints
    final publicEndpoints = [
      '/dealer/auth/send-otp',
      '/dealer/auth/verify-otp',
    ];

    final isPublicEndpoint = publicEndpoints.any(
      (endpoint) => options.path.contains(endpoint),
    );

    if (!isPublicEndpoint) {
      final token = DealerStorage.getAccessToken();
      if (token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }

    // Ensure content type is set
    options.headers['Content-Type'] = 'application/json';

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Handle 401 Unauthorized - Token expired
    if (err.response?.statusCode == 401) {
      // Try to refresh token
      final refreshed = await _refreshToken();
      if (refreshed) {
        // Retry the failed request
        try {
          final opts = err.requestOptions;
          opts.headers['Authorization'] =
              'Bearer ${DealerStorage.getAccessToken()}';

          final response = await Dio().fetch(opts);
          return handler.resolve(response);
        } catch (e) {
          // Refresh failed, clear tokens and redirect to login
          DealerStorage.clearAll();
        }
      } else {
        // Clear tokens on refresh failure
        DealerStorage.clearAll();
      }
    }
    handler.next(err);
  }

  /// Attempt to refresh the access token
  Future<bool> _refreshToken() async {
    try {
      final refreshToken = DealerStorage.getRefreshToken();
      if (refreshToken.isEmpty) return false;

      // TODO: Implement refresh token API call when endpoint is available
      // For now, return false to trigger re-login
      return false;
    } catch (e) {
      return false;
    }
  }
}
