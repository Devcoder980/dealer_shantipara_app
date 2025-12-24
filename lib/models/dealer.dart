/// Dealer model
class Dealer {
  final int id;
  final String name;
  final String email;
  final String mobile;
  final String address;
  final String state;
  final String pincode;

  Dealer({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.address,
    required this.state,
    required this.pincode,
  });

  /// Create from JSON
  factory Dealer.fromJson(Map<String, dynamic> json) {
    return Dealer(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      mobile: json['mobile'] as String? ?? '',
      address: json['address'] as String? ?? '',
      state: json['state'] as String? ?? '',
      pincode: json['pincode'] as String? ?? '',
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'mobile': mobile,
      'address': address,
      'state': state,
      'pincode': pincode,
    };
  }

  @override
  String toString() {
    return 'Dealer(id: $id, name: $name, email: $email)';
  }
}

/// Login response model
class LoginResponse {
  final bool success;
  final String message;
  final Dealer dealer;
  final String accessToken;
  final String refreshToken;
  final String expiresAt;

  LoginResponse({
    required this.success,
    required this.message,
    required this.dealer,
    required this.accessToken,
    required this.refreshToken,
    required this.expiresAt,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    return LoginResponse(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      dealer: Dealer.fromJson(data['dealer'] as Map<String, dynamic>),
      accessToken: data['accessToken'] as String? ?? '',
      refreshToken: data['refreshToken'] as String? ?? '',
      expiresAt: data['expiresAt'] as String? ?? '',
    );
  }
}

/// OTP response model
class OtpResponse {
  final bool success;
  final String message;
  final bool developmentMode;
  final String? otp;

  OtpResponse({
    required this.success,
    required this.message,
    required this.developmentMode,
    this.otp,
  });

  factory OtpResponse.fromJson(Map<String, dynamic> json) {
    return OtpResponse(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      developmentMode: json['developmentMode'] as bool? ?? false,
      otp: json['otp'] as String?,
    );
  }
}
