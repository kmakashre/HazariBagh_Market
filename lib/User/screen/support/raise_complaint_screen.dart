import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../colors/AppColors.dart';
import '../../../l10n/app_localizations.dart';


class RaiseComplaintScreen extends StatelessWidget {
  const RaiseComplaintScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: w * 0.90,
            padding: EdgeInsets.all(w * 0.04),
            margin: EdgeInsets.only(top: h * 0.02),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(w * 0.03),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow,
                  spreadRadius: 1,
                  blurRadius: 8,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// 🔴 TITLE
                Text(
                  loc.raiseComplaintTitle,
                  style: GoogleFonts.inter(
                    fontSize: w * 0.045,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),

                SizedBox(height: h * 0.015),

                /// SUBJECT
                Text(
                  loc.subject,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: w * 0.040,
                    color: AppColors.textDark,
                  ),
                ),
                SizedBox(height: h * 0.008),

                TextField(
                  decoration: InputDecoration(
                    hintText: loc.subjectHint,
                  ),
                ),

                SizedBox(height: h * 0.015),

                /// ORDER NUMBER
                Text(
                  loc.orderNumberOptional,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: w * 0.040,
                    color: AppColors.textDark,
                  ),
                ),
                SizedBox(height: h * 0.008),

                TextField(
                  decoration: InputDecoration(
                    hintText: loc.orderNumberHint,
                  ),
                ),

                SizedBox(height: h * 0.015),

                /// DESCRIPTION
                Text(
                  loc.description,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: w * 0.040,
                    color: AppColors.textDark,
                  ),
                ),
                SizedBox(height: h * 0.008),

                TextField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: loc.descriptionHint,
                  ),
                ),

                SizedBox(height: h * 0.02),

                /// SUBMIT BUTTON
                SizedBox(
                  width: double.infinity,
                  height: h * 0.055,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                    ),
                    child: Text(
                      loc.submitComplaint,
                      style: GoogleFonts.inter(
                        fontSize: w * 0.040,
                        fontWeight: FontWeight.w600,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: h * 0.012),

                Center(
                  child: Text(
                    loc.complaintResponseNote,
                    style: GoogleFonts.inter(
                      color: AppColors.textGrey,
                      fontSize: w * 0.035,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
