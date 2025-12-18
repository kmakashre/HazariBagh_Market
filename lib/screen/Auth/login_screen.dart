import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../colors/AppColors.dart';
import '../../provider/auth_provider.dart';
import '../flash_screen.dart';
import 'otp_verification_screen.dart';
import 'registration_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final mq = MediaQuery.of(context).size;
    final height = mq.height;
    final width = mq.width;

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const FlashScreen()),
        );
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [

            /// 🔵 BACKGROUND IMAGE
            SizedBox(
              height: height,
              width: width,
              child: Image.asset(
                "assets/images/loginbg.png",
                fit: BoxFit.cover,
              ),
            ),

            /// 🔵 DARK OVERLAY
            Container(
              height: height,
              width: width,
              color: AppColors.darkOverlay,
            ),

            /// 🔵 MAIN CONTENT
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.07),
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    SizedBox(height: height * 0.12),

                    /// 🔵 LOGO
                    Container(
                      padding: EdgeInsets.all(width * 0.03),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary,
                      ),
                      child: Container(
                        padding: EdgeInsets.all(width * 0.03),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.white,
                        ),
                        child: Image.asset(
                          "assets/images/logo.png",
                          height: width * 0.22,
                          width: width * 0.22,
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.02),

                    Text(
                      "Sign in with your mobile number or Google",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: width * 0.035,
                      ),
                    ),

                    SizedBox(height: height * 0.03),

                    /// 🔵 MOBILE INPUT
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.inputBackground,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: auth.setMobile,
                        decoration: const InputDecoration(
                          counterText: "",
                          prefixText: "+91 ",
                          border: InputBorder.none,
                          hintText: "Enter mobile number",
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.02),

                    /// 🔵 SEND OTP BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: height * 0.06,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: auth.loading
                            ? null
                            : () async {
                          if (auth.mobile.length == 10) {
                            final success =
                            await auth.sendOtp();

                            if (success && context.mounted) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const OtpVerificationScreen(),
                                ),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Please enter valid mobile number"),
                              ),
                            );
                          }
                        },

                        child: auth.loading
                            ? const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        )
                            : Text(
                          "Send OTP",
                          style: TextStyle(
                            fontSize: width * 0.045,
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.05),

                    /// 🔵 GOOGLE LOGIN
                    SizedBox(
                      width: double.infinity,
                      height: height * 0.055,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.white,
                        ),
                        icon: Image.asset(
                          "assets/Icons/google.png",
                          height: 20,
                        ),
                        label: const Text(
                          "Sign in with Google",
                          style: TextStyle(color: AppColors.black),
                        ),
                        onPressed: () {
                          auth.googleSignIn();
                        },
                      ),
                    ),



                    SizedBox(height: height * 0.03),

                    /// 🔵 REGISTER
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "New Users? ",
                          style: TextStyle(color: Colors.white),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => RegistrationScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "Register Here",
                            style: TextStyle(
                              color: AppColors.linkBlue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: height * 0.04),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
