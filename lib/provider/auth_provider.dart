import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screen/flash_screen.dart';
import '../services/auth_api_service.dart';

class AuthProvider extends ChangeNotifier {
  String mobile = "";
  bool loading = false;

  String message = "";
  String otp = ""; // only for testing
  String token = "";
  Map<String, dynamic>? user;

  int otpTimeLeft = 30;
  Timer? _timer;

  /// ---------------------------
  /// SET MOBILE
  /// ---------------------------
  void setMobile(String value) {
    mobile = value;
    notifyListeners();
  }

  /// ---------------------------
  /// SEND OTP
  /// ---------------------------
  Future<bool> sendOtp() async {
    if (mobile.length != 10) {
      message = "Enter valid mobile number";
      notifyListeners();
      return false;
    }

    loading = true;
    message = "";
    notifyListeners();

    try {
      final data = await AuthApiService.sendOtp(mobile);
      debugPrint("SEND OTP RESPONSE: $data");

      message = data["message"] ?? "Failed to send OTP";

      if (data["success"] == true) {
        otp = data["otp"] ?? "";
        debugPrint("OTP RECEIVED FROM API: $otp");

        startOtpTimer();
        loading = false;
        notifyListeners();
        return true;
      }

      loading = false;
      notifyListeners();
      return false;
    } catch (e) {
      loading = false;
      message = "Server error. Try again";
      notifyListeners();
      debugPrint("SEND OTP ERROR: $e");
      return false;
    }
  }

  /// ---------------------------
  /// VERIFY OTP
  /// ---------------------------
  Future<bool> verifyOtp(String enteredOtp) async {
    if (enteredOtp.length != 6) {
      message = "Please enter valid OTP";
      notifyListeners();
      return false;
    }

    loading = true;
    message = "";
    notifyListeners();

    try {
      final data = await AuthApiService.verifyOtp(mobile, enteredOtp);
      debugPrint("VERIFY OTP RESPONSE: $data");

      final bool success = data["success"] == true;

      if (!success) {
        message = data["message"] ?? "Wrong OTP";
        loading = false;
        notifyListeners();
        return false; // ❌ WRONG OTP
      }

      /// ✅ SUCCESS
      token = data["token"];
      user = data["user"];
      message = data["message"] ?? "Login successful";

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool("isLoggedIn", true);
      await prefs.setString("token", token);

      loading = false;
      notifyListeners();
      return true;
    } catch (e) {
      loading = false;
      message = "Invalid OTP or server error";
      notifyListeners();
      debugPrint("VERIFY OTP ERROR: $e");
      return false;
    }
  }

  /// ---------------------------
  /// RESEND OTP
  /// ---------------------------
  Future<void> resendOtp() async {
    if (otpTimeLeft == 0) {
      await sendOtp();
    }
  }

  /// ---------------------------
  /// GOOGLE SIGN-IN (TEMP)
  /// ---------------------------
  void googleSignIn() {
    debugPrint("Google Sign-In clicked");
  }

  /// ---------------------------
  /// LOGOUT
  /// ---------------------------
  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    /// RESET STATE
    mobile = "";
    otp = "";
    token = "";
    user = null;
    otpTimeLeft = 0;

    notifyListeners();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const FlashScreen()),
          (route) => false,
    );
  }

  /// ---------------------------
  /// OTP TIMER
  /// ---------------------------
  void startOtpTimer() {
    otpTimeLeft = 30;
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (otpTimeLeft == 0) {
        timer.cancel();
      } else {
        otpTimeLeft--;
      }
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
