import 'package:flutter/material.dart';
import '../../../widgets/top_header.dart';
import '../../../l10n/app_localizations.dart';
import 'job_apply_form_screen.dart';

/// 🎯 PRIMARY COLOR
const Color primaryColor = Color(0xFF84B3B6);

class JobDetailsScreen extends StatelessWidget {
  const JobDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final loc = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          const TopHeader(),

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
                          Icon(Icons.arrow_back,
                              color: primaryColor, size: w * 0.055),
                          SizedBox(width: w * 0.02),
                          Text(
                            loc.back,
                            style: TextStyle(
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

                  /// 🏢 JOB INFO
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.03),
                    child: _card(
                      w,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: w * 0.08,
                                backgroundColor:
                                primaryColor.withOpacity(0.2),
                                child: Icon(Icons.business,
                                    color: primaryColor, size: w * 0.07),
                              ),
                              SizedBox(width: w * 0.03),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      loc.getByKey("techSolutions"),
                                      style: TextStyle(
                                        fontSize: w * 0.042,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: h * 0.005),
                                    Chip(
                                      backgroundColor: primaryColor,
                                      label: Text(
                                        loc.itSoftware,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: w * 0.032,
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
                            loc.getByKey("jobLocation"),
                            w,
                          ),
                          _infoRow(
                            Icons.currency_rupee,
                            loc.getByKey("jobSalary"),
                            w,
                          ),
                          _infoRow(
                            Icons.work,
                            loc.getByKey("jobExperience"),
                            w,
                          ),

                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              loc.getByKey("jobPosted"),
                              style: TextStyle(
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
                    title: loc.getByKey("description"),
                    content: loc.getByKey("jobDescription"),
                  ),

                  SizedBox(height: h * 0.02),

                  /// 🧠 SKILLS
                  _section(
                    w,
                    title: loc.getByKey("requiredSkills"),
                    content: loc.getByKey("jobSkills"),
                  ),

                  SizedBox(height: h * 0.02),

                  /// 📞 CONTACT
                  _section(
                    w,
                    title: loc.getByKey("contactInformation"),
                    content: loc.getByKey("jobContact"),
                  ),

                  SizedBox(height: h * 0.03),

                  /// 🎯 BUTTONS
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
                                loc.getByKey("applyNow"),
                                style: const TextStyle(color: Colors.white),
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
                              child: Text(loc.getByKey("callEmployer")),
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

  // 🔹 CARD
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

  // 🔹 SECTION
  static Widget _section(double w,
      {required String title, required String content}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w * 0.03),
      child: _card(
        w,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(
                    fontSize: w * 0.042, fontWeight: FontWeight.bold)),
            SizedBox(height: w * 0.02),
            Text(content, style: TextStyle(fontSize: w * 0.034)),
          ],
        ),
      ),
    );
  }

  // 🔹 INFO ROW
  static Widget _infoRow(IconData icon, String text, double w) {
    return Padding(
      padding: EdgeInsets.only(bottom: w * 0.015),
      child: Row(
        children: [
          Icon(icon, size: w * 0.045, color: primaryColor),
          SizedBox(width: w * 0.02),
          Expanded(
            child: Text(text, style: TextStyle(fontSize: w * 0.034)),
          ),
        ],
      ),
    );
  }
}
