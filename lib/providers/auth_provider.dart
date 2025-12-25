import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/dealer.dart';
import '../services/auth_service.dart';
import '../utils/hive_config.dart';
import '../pages/login_page.dart';
import '../pages/dashboard_page.dart';

/// Initial route provider based on auth state
final initialRouteProvider = Provider<String>((ref) {
  final token = DealerStorage.getAccessToken();
  if (token.isEmpty || DealerStorage.isTokenExpired()) {
    return LoginPage.routeName;
  }
  return DashboardPage.routeName;
});

/// Auth state
enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthState {
  final AuthStatus status;
  final Dealer? dealer;
  final String? error;
  final String? otpEmail;
  final String? devOtp; // OTP for development mode

  AuthState({
    this.status = AuthStatus.initial,
    this.dealer,
    this.error,
    this.otpEmail,
    this.devOtp,
  });

  AuthState copyWith({
    AuthStatus? status,
    Dealer? dealer,
    String? error,
    String? otpEmail,
    String? devOtp,
  }) {
    return AuthState(
      status: status ?? this.status,
      dealer: dealer ?? this.dealer,
      error: error,
      otpEmail: otpEmail ?? this.otpEmail,
      devOtp: devOtp,
    );
  }
}

/// Auth notifier
class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState());

  /// Send OTP to email
  Future<bool> sendOtp(String email) async {
    state = state.copyWith(status: AuthStatus.loading);

    final response = await AuthService.sendOtp(email);

    if (response.success) {
      state = state.copyWith(
        status: AuthStatus.initial,
        otpEmail: email,
        devOtp: response.developmentMode ? response.otp : null,
      );
      return true;
    } else {
      state = state.copyWith(
        status: AuthStatus.error,
        error: response.message,
      );
      return false;
    }
  }

  /// Verify OTP and login
  Future<bool> verifyOtp(String otp) async {
    if (state.otpEmail == null) {
      state = state.copyWith(
        status: AuthStatus.error,
        error: 'Email not found. Please request OTP again.',
      );
      return false;
    }

    state = state.copyWith(status: AuthStatus.loading);

    try {
      final response = await AuthService.verifyOtp(
        email: state.otpEmail!,
        otp: otp,
      );

      if (response.success) {
        state = state.copyWith(
          status: AuthStatus.authenticated,
          dealer: response.dealer,
        );
        return true;
      } else {
        state = state.copyWith(
          status: AuthStatus.error,
          error: response.message,
        );
        return false;
      }
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        error: e.toString(),
      );
      return false;
    }
  }

  /// Logout
  Future<void> logout() async {
    await AuthService.logout();
    state = AuthState(status: AuthStatus.unauthenticated);
  }

  /// Clear error
  void clearError() {
    state = state.copyWith(status: AuthStatus.initial, error: null);
  }
}

/// Auth provider
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

/// Current dealer provider
final currentDealerProvider = Provider<Dealer?>((ref) {
  return ref.watch(authProvider).dealer;
});
