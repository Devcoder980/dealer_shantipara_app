/// API Endpoints for Dealer Portal
class ApiEndpoints {
  // Base URL
  static const String baseUrl = 'https://dealer.shantipatra.com/api/v1';

  // ============ Authentication ============
  /// POST - Send OTP to dealer email
  static const String sendOtp = '/dealer/auth/send-otp';

  /// POST - Verify OTP and login
  static const String verifyOtp = '/dealer/auth/verify-otp';

  /// POST - Refresh access token
  static const String refreshToken = '/dealer/auth/refresh-token';

  // ============ Orders ============
  /// GET - Get order statistics
  static const String orderStats = '/dealer/orders/stats';

  /// GET - Get paginated orders list
  static const String orders = '/dealer/orders';

  /// GET - Get order by SO number
  static String orderDetail(String soNumber) => '/dealer/orders/$soNumber';

  // ============ Commission ============
  /// GET - Get commission summary with orders
  static String commissionSummary({required int year, required int month}) =>
      '/dealer/commission/summary?year=$year&month=$month';
}
