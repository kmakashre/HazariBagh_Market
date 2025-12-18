import 'dart:convert';
import 'package:http/http.dart' as http;

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
}
