import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../widgets/top_header.dart';


class JobApplyFormScreen extends StatelessWidget {
  const JobApplyFormScreen({super.key});

  /// 🎯 PRIMARY COLOR
  static const Color primaryColor = Color(0xFF84B3B6);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final w = mq.width;
    final h = mq.height;
    final loc = AppLocalizations.of(context);

    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bgColor = isDark ? const Color(0xFF0F172A) : const Color(0xFFF5F7FA);
    final cardColor = isDark ? const Color(0xFF1E293B) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final hintColor =
    isDark ? Colors.grey.shade400 : Colors.grey.shade600;

    return Scaffold(
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔵 TOP HEADER
            const TopHeader(),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: h * 0.015),

                  /// 🔙 BACK & TITLE
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_back_ios_new,
                          color: primaryColor,
                          size: w * 0.05,
                        ),
                        SizedBox(width: w * 0.02),
                        Text(
                          loc.getByKey("applyForJob"),
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: w * 0.042,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: h * 0.01),

                  /// SUBTITLE
                  Text(
                    loc.getByKey("applyJobSubtitle"),
                    style: TextStyle(
                      fontSize: w * 0.032,
                      color: hintColor,
                    ),
                  ),

                  SizedBox(height: h * 0.025),

                  /// 📝 FORM CARD
                  Container(
                    padding: EdgeInsets.all(w * 0.045),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildTextField(
                          w,
                          textColor,
                          hintColor,
                          loc.getByKey("fullName"),
                          loc.getByKey("fullNameHint"),
                        ),
                        _buildTextField(
                          w,
                          textColor,
                          hintColor,
                          loc.getByKey("phoneNumber"),
                          loc.getByKey("phoneHint"),
                          keyboardType: TextInputType.phone,
                        ),
                        _buildTextField(
                          w,
                          textColor,
                          hintColor,
                          loc.getByKey("email"),
                          loc.getByKey("emailHint"),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        _buildTextField(
                          w,
                          textColor,
                          hintColor,
                          loc.getByKey("totalExperience"),
                          loc.getByKey("experienceHint"),
                        ),
                        _buildMultiLineField(
                          w,
                          textColor,
                          hintColor,
                          loc.getByKey("coverLetter"),
                          loc.getByKey("coverLetterHint"),
                        ),

                        SizedBox(height: h * 0.02),

                        /// 🚀 SUBMIT BUTTON
                        SizedBox(
                          width: double.infinity,
                          height: h * 0.055,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              elevation: 0,
                            ),
                            onPressed: () {
                              // TODO: submit logic
                            },
                            child: Text(
                              loc.getByKey("submitApplication"),
                              style: TextStyle(
                                fontSize: w * 0.04,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: h * 0.04),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 NORMAL TEXT FIELD
  Widget _buildTextField(
      double w,
      Color textColor,
      Color hintColor,
      String label,
      String hint, {
        TextInputType keyboardType = TextInputType.text,
      }) {
    return Padding(
      padding: EdgeInsets.only(bottom: w * 0.04),
      child: TextField(
        keyboardType: keyboardType,
        style: TextStyle(color: textColor, fontSize: w * 0.035),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          labelStyle: TextStyle(color: hintColor, fontSize: w * 0.034),
          hintStyle: TextStyle(color: hintColor, fontSize: w * 0.033),
          contentPadding: EdgeInsets.symmetric(
            horizontal: w * 0.04,
            vertical: w * 0.032,
          ),
          filled: true,
          fillColor: Colors.transparent,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: hintColor.withOpacity(0.4)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide:
            const BorderSide(color: primaryColor, width: 1.5),
          ),
        ),
      ),
    );
  }

  /// 🔹 MULTILINE FIELD
  Widget _buildMultiLineField(
      double w,
      Color textColor,
      Color hintColor,
      String label,
      String hint,
      ) {
    return Padding(
      padding: EdgeInsets.only(bottom: w * 0.04),
      child: TextField(
        maxLines: 4,
        style: TextStyle(color: textColor, fontSize: w * 0.035),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          labelStyle: TextStyle(color: hintColor, fontSize: w * 0.034),
          hintStyle: TextStyle(color: hintColor, fontSize: w * 0.033),
          contentPadding: EdgeInsets.all(w * 0.04),
          filled: true,
          fillColor: Colors.transparent,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: hintColor.withOpacity(0.4)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide:
            const BorderSide(color: primaryColor, width: 1.5),
          ),
        ),
      ),
    );
  }
}
