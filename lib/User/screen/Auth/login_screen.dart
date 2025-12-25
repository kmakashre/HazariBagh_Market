import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hazari_bagh_market/widgets/home_page.dart';
import 'package:provider/provider.dart';
import '../../../colors/AppColors.dart';
import '../../provider/auth_provider.dart';
import '../home/home_screen.dart';
import 'otp_verification_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TapGestureRecognizer privacyTap;
  late TapGestureRecognizer termsTap;

  @override
  void initState() {
    super.initState();
    privacyTap = TapGestureRecognizer();
    termsTap = TapGestureRecognizer();
  }

  @override
  void dispose() {
    privacyTap.dispose();
    termsTap.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [

          /// 🔹 BACKGROUND IMAGE
          SizedBox(
            height: size.height,
            width: size.width,
            child: Image.asset(
              "assets/images/loginbg.png",
              fit: BoxFit.cover,
            ),
          ),

          /// 🔹 DARK OVERLAY
          Container(color: Colors.black.withOpacity(0.6)),

          /// 🔹 CONTENT
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  SizedBox(height: size.height * 0.09),

                  /// 🔹 LOGO (EXACT MATCH)
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Image.asset(
                        "assets/images/logo.png",
                        height: 68,
                        width: 68,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// 🔹 SUB TITLE
                  const Text(
                    "Sign in with your mobile number or Google",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                  ),

                  const SizedBox(height: 26),

                  /// 🔹 MOBILE LABEL
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Mobile number",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  const SizedBox(height: 6),

                  /// 🔹 MOBILE INPUT
                  Container(
                    height: 46,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      maxLength: 10,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      onChanged: auth.setMobile,
                      decoration: const InputDecoration(
                        counterText: "",
                        prefixText: "+91  ",
                        hintText: "Enter Your Number",
                        border: InputBorder.none,
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  /// 🔹 SEND OTP BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 46,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3E7CB1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(color: Colors.white),
                        ),
                      ),
                      onPressed: auth.loading
                          ? null
                          : () async {
                        // ✅ Mobile number validation
                        if (auth.mobile.length != 10) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Enter valid mobile number"),
                            ),
                          );
                          return;
                        }

                        // ✅ Send OTP
                        final bool success = await auth.sendOtp();

                        // ✅ Navigate to OTP screen
                        if (success && context.mounted) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const OtpVerificationScreen(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(auth.message)),
                          );
                        }
                      },
                      child: auth.loading
                          ? const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      )
                          : const Text(
                        "Send OTP",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// 🔹 OR DIVIDER
                  Row(
                    children: const [
                      Expanded(child: Divider(color: Colors.white30)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "or",
                          style: TextStyle(color: Colors.white70),
                        ),
                      ),
                      Expanded(child: Divider(color: Colors.white30)),
                    ],
                  ),

                  const SizedBox(height: 22),

                  /// 🔹 GOOGLE BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      icon: Image.asset(
                        "assets/Icons/google.png",
                        height: 20,
                      ),
                      label: const Text(
                        "Sign in with Google",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                        ),
                      ),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>HomePage()));
                      },
                    ),
                  ),

                  const SizedBox(height: 22),

                  /// 🔹 REGISTER
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "New Users? ",
                        style: TextStyle(color: Colors.white70),
                      ),
                      Text(
                        "Register Here",
                        style: TextStyle(
                          color: AppColors.linkBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  /// 🔹 PRIVACY & TERMS (CLICKABLE)
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 11,
                      ),
                      children: [
                        const TextSpan(
                          text: "By signing in you agree to our ",
                        ),
                        TextSpan(
                          text: "Privacy\nPolicy",
                          style: const TextStyle(
                            color: AppColors.linkBlue,
                            fontWeight: FontWeight.w500,
                          ),
                          recognizer: privacyTap
                            ..onTap = () {
                              debugPrint("Privacy Policy clicked");
                            },
                        ),
                        const TextSpan(text: " and "),
                        TextSpan(
                          text: "Terms.",
                          style: const TextStyle(
                            color: AppColors.linkBlue,
                            fontWeight: FontWeight.w500,
                          ),
                          recognizer: termsTap
                            ..onTap = () {
                              debugPrint("Terms clicked");
                            },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
