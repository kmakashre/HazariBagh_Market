import 'package:flutter/material.dart';
import '../../../widgets/top_header.dart';
import '../../../l10n/app_localizations.dart';

class JobApplyFormScreen extends StatelessWidget {
  const JobApplyFormScreen({super.key});

  /// 🎯 PRIMARY THEME COLOR
  static const Color primaryColor = Color(0xFF84B3B6);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final width = mq.width;
    final height = mq.height;
    final loc = AppLocalizations.of(context);

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
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_back,
                          color: primaryColor,
                          size: width * 0.055,
                        ),
                        SizedBox(width: width * 0.02),
                        Text(
                          loc.getByKey("applyForJob"),
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: width * 0.038,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: height * 0.012),

                  /// SUBTITLE
                  Text(
                    loc.getByKey("applyJobSubtitle"),
                    style: TextStyle(
                      fontSize: width * 0.032,
                      color: Colors.grey.shade700,
                    ),
                  ),

                  SizedBox(height: height * 0.02),

                  /// FORM CARD
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
                            width,
                            loc.getByKey("fullName"),
                            loc.getByKey("fullNameHint"),
                          ),
                          _buildTextField(
                            width,
                            loc.getByKey("phoneNumber"),
                            loc.getByKey("phoneHint"),
                          ),
                          _buildTextField(
                            width,
                            loc.getByKey("email"),
                            loc.getByKey("emailHint"),
                          ),
                          _buildTextField(
                            width,
                            loc.getByKey("totalExperience"),
                            loc.getByKey("experienceHint"),
                          ),
                          _buildMultiLineField(
                            width,
                            loc.getByKey("coverLetter"),
                            loc.getByKey("coverLetterHint"),
                          ),

                          SizedBox(height: height * 0.02),

                          /// SUBMIT BUTTON
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
                              ),
                              onPressed: () {},
                              child: Text(
                                loc.getByKey("submitApplication"),
                                style: TextStyle(
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
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          labelStyle: TextStyle(fontSize: width * 0.035),
          hintStyle: TextStyle(fontSize: width * 0.034),
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
            borderSide: const BorderSide(color: primaryColor, width: 1.5),
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
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          labelStyle: TextStyle(fontSize: width * 0.035),
          hintStyle: TextStyle(fontSize: width * 0.034),
          contentPadding: EdgeInsets.all(width * 0.035),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(width * 0.025),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(width * 0.025),
            borderSide: const BorderSide(color: primaryColor, width: 1.5),
          ),
        ),
      ),
    );
  }
}
