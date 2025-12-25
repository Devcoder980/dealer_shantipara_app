import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import '../providers/auth_provider.dart';
import '../routes/routers.dart';
import 'dashboard_page.dart';

/// OTP verification page
class OtpPage extends ConsumerStatefulWidget {
  static const String routeName = '/otp';

  const OtpPage({super.key});

  @override
  ConsumerState<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends ConsumerState<OtpPage> {
  bool _isLoading = false;
  String _otp = '';

  Future<void> _verifyOtp() async {
    if (_otp.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter complete OTP'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    final success = await ref.read(authProvider.notifier).verifyOtp(_otp);

    setState(() => _isLoading = false);

    if (success && mounted) {
      Routers.navigateAndClearStack(context, DashboardPage.routeName);
    } else {
      final error = ref.read(authProvider).error;
      if (error != null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final email = authState.otpEmail ?? '';
    final devOtp = authState.devOtp;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify OTP'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),

              // Icon
              const Icon(
                Icons.lock_outline,
                size: 60,
                color: Color(0xFF1E88E5),
              ),
              const SizedBox(height: 24),

              // Title
              const Text(
                'Enter OTP',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              // Subtitle
              Text(
                'We have sent a 6-digit OTP to\n$email',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 32),

              // Dev mode OTP hint
              if (devOtp != null) ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.amber),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.bug_report, color: Colors.amber),
                      const SizedBox(width: 8),
                      Text(
                        'Dev Mode OTP: $devOtp',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.amber,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],

              // OTP field
              OtpTextField(
                numberOfFields: 6,
                borderColor: const Color(0xFF1E88E5),
                focusedBorderColor: const Color(0xFF1E88E5),
                showFieldAsBox: true,
                borderRadius: BorderRadius.circular(8),
                fieldWidth: 45,
                onSubmit: (code) {
                  _otp = code;
                  _verifyOtp();
                },
                onCodeChanged: (code) {
                  _otp = code;
                },
              ),
              const SizedBox(height: 32),

              // Verify button
              ElevatedButton(
                onPressed: _isLoading ? null : _verifyOtp,
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text('Verify & Login'),
              ),
              const SizedBox(height: 16),

              // Resend OTP
              TextButton(
                onPressed: _isLoading
                    ? null
                    : () async {
                        setState(() => _isLoading = true);
                        await ref.read(authProvider.notifier).sendOtp(email);
                        setState(() => _isLoading = false);
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('OTP sent again!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        }
                      },
                child: const Text('Didn\'t receive OTP? Resend'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
