import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Model/user_model.dart';

class AuthApiService {
  static const String baseUrl = "http://192.168.29.166:5678/user";

  /// SEND OTP
  static Future<Map<String, dynamic>> sendOtp(String mobile) async {
    final response = await http.post(
      Uri.parse("$baseUrl/sendotp"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"phone": mobile}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Send OTP failed");
    }
  }

  /// VERIFY OTP
  static Future<Map<String, dynamic>> verifyOtp(
      String mobile, String otp) async {
    final response = await http.post(
      Uri.parse("$baseUrl/verifyotp"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "phone": mobile,
        "otp": otp,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Verify OTP failed");
    }
  }

  /// ✅ GET USER PROFILE (FINAL & CLEAN)
  static Future<UserProfileResponse> getUserProfile(String token) async {
    final response = await http.get(
      Uri.parse("$baseUrl/profile"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      return UserProfileResponse.fromJson(
        jsonDecode(response.body),
      );
    } else {
      throw Exception("Failed to load user profile");
    }
  }

  static Future<void> deleteAccount(String token) async {
    final response = await http.delete(
      Uri.parse("$baseUrl/delete"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to delete account");
    }
  }


}
