import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:hive_flutter/hive_flutter.dart';

/// Hive box name for dealer data
const String _dealerBoxName = 'dealer';

/// Initialize Hive for local storage
/// Supports both mobile and web platforms
Future<void> initHive() async {
  // Use hive_flutter for cross-platform support (including web)
  await Hive.initFlutter();
  await Hive.openBox(_dealerBoxName);
}

/// Dealer local storage using Hive
/// Similar pattern to reference repository's HiveUser class
class DealerStorage {
  static Box get _box => Hive.box(_dealerBoxName);

  // ============ Authentication Tokens ============

  /// Get access token
  static String getAccessToken() => _box.get('accessToken') ?? '';

  /// Set access token
  static Future<void> setAccessToken(String token) =>
      _box.put('accessToken', token);

  /// Get refresh token
  static String getRefreshToken() => _box.get('refreshToken') ?? '';

  /// Set refresh token
  static Future<void> setRefreshToken(String token) =>
      _box.put('refreshToken', token);

  /// Get token expiry time
  static DateTime? getTokenExpiry() {
    final expiry = _box.get('tokenExpiry');
    if (expiry is String) {
      return DateTime.tryParse(expiry);
    }
    return null;
  }

  /// Set token expiry time
  static Future<void> setTokenExpiry(String expiresAt) =>
      _box.put('tokenExpiry', expiresAt);

  /// Check if token is expired
  static bool isTokenExpired() {
    final expiry = getTokenExpiry();
    if (expiry == null) return true;
    return DateTime.now().isAfter(expiry);
  }

  // ============ Dealer Info ============

  /// Get dealer ID
  static int getDealerId() => _box.get('dealerId') ?? 0;

  /// Set dealer ID
  static Future<void> setDealerId(int id) => _box.put('dealerId', id);

  /// Get dealer name
  static String getDealerName() => _box.get('dealerName') ?? '';

  /// Set dealer name
  static Future<void> setDealerName(String name) => _box.put('dealerName', name);

  /// Get dealer email
  static String getDealerEmail() => _box.get('dealerEmail') ?? '';

  /// Set dealer email
  static Future<void> setDealerEmail(String email) =>
      _box.put('dealerEmail', email);

  /// Get dealer mobile
  static String getDealerMobile() => _box.get('dealerMobile') ?? '';

  /// Set dealer mobile
  static Future<void> setDealerMobile(String mobile) =>
      _box.put('dealerMobile', mobile);

  /// Get dealer address
  static String getDealerAddress() => _box.get('dealerAddress') ?? '';

  /// Set dealer address
  static Future<void> setDealerAddress(String address) =>
      _box.put('dealerAddress', address);

  /// Get dealer state
  static String getDealerState() => _box.get('dealerState') ?? '';

  /// Set dealer state
  static Future<void> setDealerState(String state) =>
      _box.put('dealerState', state);

  /// Get dealer pincode
  static String getDealerPincode() => _box.get('dealerPincode') ?? '';

  /// Set dealer pincode
  static Future<void> setDealerPincode(String pincode) =>
      _box.put('dealerPincode', pincode);

  // ============ App State ============

  /// Check if first time user
  static bool isFirstTime() => _box.get('isFirstTime') ?? true;

  /// Set first time flag
  static Future<void> setFirstTime(bool value) => _box.put('isFirstTime', value);

  // ============ Utility Methods ============

  /// Save all dealer info from login response
  static Future<void> saveDealerInfo({
    required int id,
    required String name,
    required String email,
    required String mobile,
    required String address,
    required String state,
    required String pincode,
  }) async {
    await Future.wait([
      setDealerId(id),
      setDealerName(name),
      setDealerEmail(email),
      setDealerMobile(mobile),
      setDealerAddress(address),
      setDealerState(state),
      setDealerPincode(pincode),
    ]);
  }

  /// Save authentication tokens
  static Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
    required String expiresAt,
  }) async {
    await Future.wait([
      setAccessToken(accessToken),
      setRefreshToken(refreshToken),
      setTokenExpiry(expiresAt),
    ]);
  }

  /// Clear all stored data (logout)
  static Future<void> clearAll() async {
    await _box.clear();
  }

  /// Check if user is logged in
  static bool isLoggedIn() {
    final token = getAccessToken();
    return token.isNotEmpty && !isTokenExpired();
  }
}
