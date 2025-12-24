import 'package:flutter/material.dart';
import '../../colors/AppColors.dart';
import 'Auth/login_screen.dart';
import 'Auth/registration_screen.dart';

class FlashScreen extends StatelessWidget {
  const FlashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final h = size.height;
    final w = size.width;

    return Scaffold(
      backgroundColor: AppColors.white,

      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    /// 🔵 TOP SECTION
                    Column(
                      children: [

                        /// 🖼 IMAGE
                        SizedBox(
                          height: h * 0.50,
                          width: w,
                          child: Image.asset(
                            'assets/images/flashImg.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),

                        /// 🔵 LOGO OVER IMAGE
                        Transform.translate(
                          offset: Offset(0, -h * 0.07),
                          child: Container(
                            padding: EdgeInsets.all(w * 0.030),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primary,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.black.withOpacity(0.25),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Container(
                              padding: EdgeInsets.all(w * 0.03),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.white,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.asset(
                                  "assets/images/logo.png",
                                  height: w * 0.22,
                                  width: w * 0.22,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: h * 0.005),

                        /// 🏷 TITLE
                        Text(
                          "One App",
                          style: TextStyle(
                            fontSize: w * 0.06,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),

                        SizedBox(height: h * 0.01),

                        /// 📝 SUBTITLE
                        Text(
                          "\"Your trusted marketplace for every\ncategory\"",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: w * 0.032,
                            color: AppColors.textLight,
                            height: 1.3,
                          ),
                        ),

                        SizedBox(height: h * 0.025),

                        /// 🔘 BUTTONS
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: w * 0.07),
                          child: Row(
                            children: [

                              /// CUSTOMER BUTTON
                              Expanded(
                                child: SizedBox(
                                  height: h * 0.05,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(w * 0.02),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                          const LoginScreen(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "I'm a customer",
                                      style: TextStyle(
                                        fontSize: w * 0.034,
                                        color: AppColors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(width: w * 0.03),

                              /// VENDOR BUTTON
                              Expanded(
                                child: SizedBox(
                                  height: h * 0.05,
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(
                                        color: AppColors.black,
                                        width: w * 0.003,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(w * 0.02),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                          const RegistrationScreen(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "I'm a vendor",
                                      style: TextStyle(
                                        fontSize: w * 0.034,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    /// 🔵 BOTTOM LOGIN TEXT
                    Padding(
                      padding: EdgeInsets.only(bottom: h * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: TextStyle(
                              fontSize: w * 0.033,
                              color: AppColors.textLight,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const LoginScreen(),
                                ),
                              );
                            },
                            child: Text(
                              "Log in",
                              style: TextStyle(
                                fontSize: w * 0.033,
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
