import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../widgets/top_header.dart';
import 'job_apply_form_screen.dart';

/// 🎯 PRIMARY COLOR
const Color primaryColor = Color(0xFF84B3B6);

class JobDetailsScreen extends StatelessWidget {
  const JobDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          /// 🔝 TOP HEADER
          const TopHeader(),

          /// 🔽 SCROLLABLE CONTENT
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: h * 0.015),

                  /// 🔙 BACK
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.03),
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_back,
                            color: primaryColor,
                            size: w * 0.055,
                          ),
                          SizedBox(width: w * 0.02),
                          Text(
                            "Back",
                            style: GoogleFonts.inter(
                              color: primaryColor,
                              fontSize: w * 0.04,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: h * 0.02),

                  /// 🏢 JOB INFO CARD
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.03),
                    child: _card(
                      w,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: w * 0.08,
                                backgroundColor:
                                primaryColor.withOpacity(0.2),
                                child: Icon(
                                  Icons.business,
                                  color: primaryColor,
                                  size: w * 0.07,
                                ),
                              ),
                              SizedBox(width: w * 0.03),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Tech Solutions Pvt Ltd",
                                      style: GoogleFonts.inter(
                                        fontSize: w * 0.042,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: h * 0.005),
                                    Chip(
                                      backgroundColor: primaryColor,
                                      label: Text(
                                        "IT & Software",
                                        style: GoogleFonts.inter(
                                          color: Colors.white,
                                          fontSize: w * 0.032,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: h * 0.015),

                          _infoRow(
                            Icons.location_on,
                            "Indore – Hazaribagh (Work From Office)",
                            w,
                          ),
                          _infoRow(
                            Icons.currency_rupee,
                            "Salary: 4–6 LPA",
                            w,
                          ),
                          _infoRow(
                            Icons.work,
                            "Experience: 2–4 Years",
                            w,
                          ),

                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Posted: 2 days ago",
                              style: GoogleFonts.inter(
                                fontSize: w * 0.03,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: h * 0.02),

                  /// 📄 DESCRIPTION
                  _section(
                    w,
                    title: "Description",
                    content:
                    "Looking for an experienced full stack developer.",
                  ),

                  SizedBox(height: h * 0.02),

                  /// 🧠 SKILLS
                  _section(
                    w,
                    title: "Required Skills",
                    content: "React, Node.js, TypeScript, MongoDB",
                  ),

                  SizedBox(height: h * 0.02),

                  /// 📞 CONTACT
                  _section(
                    w,
                    title: "Contact Information",
                    content:
                    "📞 +91-4321098765\n✉ careers@techsolutions.com",
                  ),

                  SizedBox(height: h * 0.03),

                  /// 🎯 ACTION BUTTONS
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.03),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: h * 0.055,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(w * 0.025),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                    const JobApplyFormScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                "Apply Now",
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: w * 0.038,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: w * 0.03),
                        Expanded(
                          child: SizedBox(
                            height: h * 0.055,
                            child: OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(w * 0.025),
                                ),
                                side: const BorderSide(
                                    color: primaryColor),
                              ),
                              child: Text(
                                "Call Employer",
                                style: GoogleFonts.inter(
                                  color: primaryColor,
                                  fontSize: w * 0.036,
                                  fontWeight: FontWeight.w600,
                                ),
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
          ),
        ],
      ),
    );
  }

  /// 🔹 CARD
  static Widget _card(double w, Widget child) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(w * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(w * 0.04),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4),
        ],
      ),
      child: child,
    );
  }

  /// 🔹 SECTION
  static Widget _section(
      double w, {
        required String title,
        required String content,
      }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w * 0.03),
      child: _card(
        w,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: w * 0.042,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: w * 0.02),
            Text(
              content,
              style: GoogleFonts.inter(
                fontSize: w * 0.034,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 INFO ROW
  static Widget _infoRow(IconData icon, String text, double w) {
    return Padding(
      padding: EdgeInsets.only(bottom: w * 0.015),
      child: Row(
        children: [
          Icon(icon, size: w * 0.045, color: primaryColor),
          SizedBox(width: w * 0.02),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.inter(
                fontSize: w * 0.034,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
