/// App-wide constants
class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'Shanti Patra Dealer';
  static const String appVersion = '1.0.0';

  // API
  static const int apiTimeout = 30; // seconds

  // Pagination
  static const int defaultPageSize = 10;
  static const int maxPageSize = 100;

  // OTP
  static const int otpLength = 6;
  static const int otpResendTimeout = 60; // seconds

  // Storage Keys
  static const String accessTokenKey = 'accessToken';
  static const String refreshTokenKey = 'refreshToken';
  static const String dealerInfoKey = 'dealerInfo';
}

/// Order status enum with display values
enum OrderStatus {
  pending('PENDING', 'Pending'),
  approved('APPROVED', 'Approved'),
  inProduction('IN_PRODUCTION', 'In Production'),
  dispatched('DISPATCHED', 'Dispatched'),
  delivered('DELIVERED', 'Delivered'),
  cancelled('CANCELLED', 'Cancelled');

  final String value;
  final String displayName;

  const OrderStatus(this.value, this.displayName);

  static OrderStatus fromString(String value) {
    return OrderStatus.values.firstWhere(
      (status) => status.value == value,
      orElse: () => OrderStatus.pending,
    );
  }
}

/// Payment terms enum
enum PaymentTerm {
  immediate('IMMEDIATE', 'Immediate'),
  credit15('CREDIT_15', '15 Days Credit'),
  credit30('CREDIT_30', '30 Days Credit'),
  credit45('CREDIT_45', '45 Days Credit');

  final String value;
  final String displayName;

  const PaymentTerm(this.value, this.displayName);

  static PaymentTerm fromString(String value) {
    return PaymentTerm.values.firstWhere(
      (term) => term.value == value,
      orElse: () => PaymentTerm.immediate,
    );
  }
}
