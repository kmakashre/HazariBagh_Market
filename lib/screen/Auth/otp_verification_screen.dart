import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hazari_bagh_market/colors/AppColors.dart';
import 'package:hazari_bagh_market/widgets/home_page.dart';
import '../../provider/auth_provider.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController otpController = TextEditingController();

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    return Scaffold(
      body: Stack(
        children: [
          /// 🔹 BACKGROUND IMAGE
          SizedBox(
            width: w,
            height: h,
            child: Image.asset(
              'assets/images/loginbg.png',
              fit: BoxFit.cover,
            ),
          ),

          /// 🔹 DARK OVERLAY
          Container(color: AppColors.darkOverlay),

          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: w * 0.08),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: h * 0.04),

                  /// 🔹 LOGO
                  CircleAvatar(
                    radius: w * 0.17,
                    backgroundColor: AppColors.primary,
                    child: CircleAvatar(
                      radius: w * 0.145,
                      backgroundColor: Colors.white,
                      backgroundImage:
                      const AssetImage("assets/images/logo.png"),
                    ),
                  ),

                  SizedBox(height: h * 0.03),

                  /// 🔹 TITLE
                  Text(
                    "Sign in with your mobile number or Google",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: w * 0.034,
                    ),
                  ),

                  SizedBox(height: h * 0.035),

                  /// 🔹 MOBILE LABEL
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Mobile number",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: w * 0.034,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  SizedBox(height: 6),

                  /// 🔹 MOBILE FIELD
                  TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      hintText: "+91 - ${auth.mobile}",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  SizedBox(height: h * 0.02),

                  /// 🔹 OTP LABEL
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Enter OTP",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: w * 0.034,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  SizedBox(height: 6),

                  /// 🔹 OTP FIELD
                  TextField(
                    controller: otpController,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    decoration: InputDecoration(
                      counterText: "",
                      hintText: "Enter OTP",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  SizedBox(height: 6),

                  /// 🔹 TIMER / RESEND
                  auth.otpTimeLeft > 0
                      ? Text(
                    "OTP expires in ${auth.otpTimeLeft} seconds",
                    style: GoogleFonts.poppins(
                      color: Colors.white70,
                      fontSize: w * 0.032,
                    ),
                  )
                      : GestureDetector(
                    onTap: auth.resendOtp,
                    child: Text(
                      "Resend OTP",
                      style: GoogleFonts.poppins(
                        color: Colors.yellowAccent,
                        fontSize: w * 0.034,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  SizedBox(height: h * 0.03),

                  /// 🔹 VERIFY BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: h * 0.055,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: auth.loading
                          ? null
                          : () async {
                        final success = await auth.verifyOtp(
                            otpController.text.trim());

                        if (success && context.mounted) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const HomePage(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(auth.message)),
                          );
                        }
                      },
                      child: auth.loading
                          ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                          : Text(
                        "Verify & Log In",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: w * 0.04,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: h * 0.04),

                  /// 🔹 TERMS
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      Text(
                        "By signing in you agree to our ",
                        style: GoogleFonts.poppins(
                          color: Colors.white70,
                          fontSize: w * 0.032,
                        ),
                      ),
                      Text(
                        "Privacy Policy",
                        style: GoogleFonts.poppins(
                          color: AppColors.linkBlue,
                          fontWeight: FontWeight.w600,
                          fontSize: w * 0.032,
                        ),
                      ),
                      Text(
                        " and ",
                        style: GoogleFonts.poppins(
                          color: Colors.white70,
                          fontSize: w * 0.032,
                        ),
                      ),
                      Text(
                        "Terms.",
                        style: GoogleFonts.poppins(
                          color: AppColors.linkBlue,
                          fontWeight: FontWeight.w600,
                          fontSize: w * 0.032,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: h * 0.02),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
