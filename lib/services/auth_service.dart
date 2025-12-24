import 'package:dio/dio.dart';
import '../core/api_endpoints.dart';
import '../core/dio_client.dart';
import '../models/dealer.dart';
import '../utils/hive_config.dart';

/// Authentication service
class AuthService {
  static final Dio _dio = DioClient.instance;

  /// Send OTP to dealer email
  /// Returns OtpResponse with success status and message
  static Future<OtpResponse> sendOtp(String email) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.sendOtp,
        data: {'email': email},
      );
      return OtpResponse.fromJson(response.data);
    } on DioException catch (e) {
      return OtpResponse(
        success: false,
        message: e.message ?? 'Failed to send OTP',
        developmentMode: false,
      );
    }
  }

  /// Verify OTP and login
  /// Returns LoginResponse with tokens and dealer info
  static Future<LoginResponse> verifyOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.verifyOtp,
        data: {
          'email': email,
          'otp': otp,
        },
      );

      final loginResponse = LoginResponse.fromJson(response.data);

      // Save tokens and dealer info to Hive
      if (loginResponse.success) {
        await DealerStorage.saveTokens(
          accessToken: loginResponse.accessToken,
          refreshToken: loginResponse.refreshToken,
          expiresAt: loginResponse.expiresAt,
        );

        await DealerStorage.saveDealerInfo(
          id: loginResponse.dealer.id,
          name: loginResponse.dealer.name,
          email: loginResponse.dealer.email,
          mobile: loginResponse.dealer.mobile,
          address: loginResponse.dealer.address,
          state: loginResponse.dealer.state,
          pincode: loginResponse.dealer.pincode,
        );
      }

      return loginResponse;
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Failed to verify OTP');
    }
  }

  /// Logout - clear all stored data
  static Future<void> logout() async {
    await DealerStorage.clearAll();
    DioClient.reset();
  }

  /// Check if user is logged in
  static bool isLoggedIn() {
    return DealerStorage.isLoggedIn();
  }
}
