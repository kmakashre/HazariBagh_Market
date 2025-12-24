import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hazari_bagh_market/Vendor/vendor Screens/vendor_dashboard_home_screen.dart';
import '../../../colors/AppColors.dart';
import '../flash_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String? selectedGender;
  bool agree = false;

  final TextEditingController fullName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController address = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const FlashScreen()),
              (route) => false,
        );
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            /// BACKGROUND IMAGE
            Container(
              height: height,
              width: width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/loginbg.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            /// DARK OVERLAY
            Container(
              height: height,
              width: width,
              color: Colors.black.withOpacity(0.65),
            ),

            /// MAIN CONTENT
            SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: width * 0.07),
                child: Column(
                  children: [
                    SizedBox(height: height * 0.05),

                    /// LOGO
                    Transform.translate(
                      offset: Offset(0, -height * 0.01),
                      child: Container(
                        padding: EdgeInsets.all(width * 0.030),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary,
                        ),
                        child: Container(
                          padding: EdgeInsets.all(width * 0.03),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.white,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              "assets/images/logo.png",
                              height: width * 0.22,
                              width: width * 0.22,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.02),

                    Text(
                      "Create Profile",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: width * 0.055,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    SizedBox(height: height * 0.005),

                    Text(
                      "Please provide the details below to\ncreate your account",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: Colors.white70,
                        fontSize: width * 0.032,
                      ),
                    ),

                    SizedBox(height: height * 0.03),

                    /// GOOGLE BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: height * 0.055,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        icon: Image.asset(
                          "assets/Icons/google.png",
                          height: height * 0.025,
                        ),
                        label: Text(
                          "Sign in with Google",
                          style: GoogleFonts.poppins(
                            color: AppColors.black,
                            fontSize: width * 0.04,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),

                    SizedBox(height: height * 0.02),

                    /// OR
                    Row(
                      children: [
                        Expanded(child: Container(height: 1, color: Colors.white30)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            "OR",
                            style: GoogleFonts.poppins(
                              color: Colors.white70,
                              fontSize: width * 0.035,
                            ),
                          ),
                        ),
                        Expanded(child: Container(height: 1, color: Colors.white30)),
                      ],
                    ),

                    SizedBox(height: height * 0.02),

                    _inputField("Full Name", Icons.person, fullName, height, width),
                    _inputField("Email Address", Icons.email, email, height, width),
                    _inputField("Phone Number", Icons.phone, phone, height, width),

                    /// GENDER + DOB
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: height * 0.055,
                            padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: _boxDecoration(),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                hint: Text(
                                  "Gender",
                                  style: GoogleFonts.poppins(),
                                ),
                                value: selectedGender,
                                items: ["Male", "Female", "Other"]
                                    .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    e,
                                    style: GoogleFonts.poppins(),
                                  ),
                                ))
                                    .toList(),
                                onChanged: (val) {
                                  setState(() => selectedGender = val);
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: width * 0.03),
                        Expanded(
                          child: Container(
                            height: height * 0.055,
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                            decoration: _boxDecoration(),
                            child: Text(
                              "DOB",
                              style: GoogleFonts.poppins(),
                            ),
                          ),
                        ),
                      ],
                    ),

                    _inputField(
                        "Home Address", Icons.location_on, address, height, width),

                    /// TERMS
                    Row(
                      children: [
                        Checkbox(
                          value: agree,
                          activeColor: Colors.white,
                          checkColor: Colors.black,
                          onChanged: (val) => setState(() => agree = val!),
                        ),
                        Text(
                          "I agree with Terms and Conditions",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: width * 0.03,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: height * 0.015),

                    /// REGISTER
                    SizedBox(
                      width: double.infinity,
                      height: height * 0.055,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3670A3),
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_)=> VendorDashboardHomeScreen()));
                        },
                        child: Text(
                          "Register & Continue",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: width * 0.04,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.018),

                    /// BACK
                    GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const FlashScreen()),
                              (route) => false,
                        );
                      },
                      child: Text(
                        "Back To Log-in",
                        style: GoogleFonts.poppins(
                          color: Colors.blueAccent,
                          fontSize: width * 0.03,
                        ),
                      ),
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

  /// INPUT FIELD
  Widget _inputField(
      String hint,
      IconData icon,
      TextEditingController controller,
      double height,
      double width,
      ) {
    return Container(
      height: height * 0.055,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: _boxDecoration(),
      child: TextField(
        controller: controller,
        style: GoogleFonts.poppins(fontSize: width * 0.038),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, size: width * 0.05),
          hintText: hint,
          hintStyle: GoogleFonts.poppins(),
          border: InputBorder.none,
        ),
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(6),
    );
  }
}
