import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../widgets/top_header.dart';

class JobApplyFormScreen extends StatelessWidget {
  const JobApplyFormScreen({super.key});

  /// 🎯 PRIMARY THEME COLOR
  static const Color primaryColor = Color(0xFF84B3B6);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final width = mq.width;
    final height = mq.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔵 TOP HEADER
            const TopHeader(),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.015),

                  /// 🔙 BACK & TITLE
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    borderRadius: BorderRadius.circular(8),
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_back,
                          color: primaryColor,
                          size: width * 0.055,
                        ),
                        SizedBox(width: width * 0.02),
                        Text(
                          "Apply For Job",
                          style: GoogleFonts.inter(
                            color: primaryColor,
                            fontSize: width * 0.04,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: height * 0.012),

                  /// 📌 SUBTITLE
                  Text(
                    "Applying For Full Stack Developer (Tech Solutions Pvt Ltd)",
                    style: GoogleFonts.inter(
                      fontSize: width * 0.032,
                      color: Colors.grey.shade700,
                      height: 1.4,
                    ),
                  ),

                  SizedBox(height: height * 0.02),

                  /// 🧾 FORM CARD
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(width * 0.03),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(width * 0.04),
                      child: Column(
                        children: [
                          _buildTextField(
                              width, "Full Name", "Enter your full name"),
                          _buildTextField(
                              width, "Phone Number", "+91-1234567890"),
                          _buildTextField(
                              width, "Email", "your.email@example.com"),
                          _buildTextField(
                              width, "Total Experience", "e.g. 2 years"),

                          _buildMultiLineField(
                            width,
                            "Cover Letter / Resume",
                            "Why are you a good fit for this position?",
                          ),

                          SizedBox(height: height * 0.02),

                          /// 🚀 SUBMIT BUTTON
                          SizedBox(
                            width: double.infinity,
                            height: height * 0.055,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(width * 0.025),
                                ),
                                elevation: 3,
                              ),
                              onPressed: () {},
                              child: Text(
                                "Submit Application",
                                style: GoogleFonts.inter(
                                  fontSize: width * 0.04,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.03),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 NORMAL TEXT FIELD
  Widget _buildTextField(double width, String label, String hint) {
    return Padding(
      padding: EdgeInsets.only(bottom: width * 0.035),
      child: TextField(
        style: GoogleFonts.inter(fontSize: width * 0.036),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          labelStyle: GoogleFonts.inter(
            fontSize: width * 0.035,
            fontWeight: FontWeight.w500,
          ),
          hintStyle: GoogleFonts.inter(
            fontSize: width * 0.034,
            color: Colors.grey.shade500,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: width * 0.035,
            vertical: width * 0.03,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(width * 0.025),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(width * 0.025),
            borderSide:
            const BorderSide(color: primaryColor, width: 1.5),
          ),
        ),
      ),
    );
  }

  /// 🔹 MULTILINE TEXT FIELD
  Widget _buildMultiLineField(double width, String label, String hint) {
    return Padding(
      padding: EdgeInsets.only(bottom: width * 0.035),
      child: TextField(
        maxLines: 4,
        style: GoogleFonts.inter(fontSize: width * 0.036),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          labelStyle: GoogleFonts.inter(
            fontSize: width * 0.035,
            fontWeight: FontWeight.w500,
          ),
          hintStyle: GoogleFonts.inter(
            fontSize: width * 0.034,
            color: Colors.grey.shade500,
          ),
          contentPadding: EdgeInsets.all(width * 0.035),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(width * 0.025),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(width * 0.025),
            borderSide:
            const BorderSide(color: primaryColor, width: 1.5),
          ),
        ),
      ),
    );
  }
}
