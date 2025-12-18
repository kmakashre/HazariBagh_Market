import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../colors/AppColors.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.bgLight,

      body: SingleChildScrollView(
        padding: EdgeInsets.all(w * 0.04),
        child: Column(
          children: [
            contactCard(
              context: context,
              icon: Icons.call_rounded,
              color: Colors.blue,
              title: "Call Us",
              subtitle: "Mon - Sun (9:00 AM - 9:00 PM)",
              actionText: "+91 98889 99999",
              onTap: () => launchUrl(
                Uri.parse("tel:+919888999999"),
              ),
            ),

            SizedBox(height: h * 0.02),

            contactCard(
              context: context,
              icon: Icons.chat_rounded,
              color: Colors.green,
              title: "WhatsApp",
              subtitle: "Quick support via WhatsApp",
              actionText: "Chat Now",
              onTap: () => launchUrl(
                Uri.parse(
                  "https://wa.me/919888999999?text=Hello",
                ),
              ),
            ),

            SizedBox(height: h * 0.02),

            contactCard(
              context: context,
              icon: Icons.email_rounded,
              color: Colors.red,
              title: "Email Us",
              subtitle: "We reply within 24 hours",
              actionText: "support@hazaribagh.market",
              onTap: () => launchUrl(
                Uri.parse(
                  "mailto:support@hazaribagh.market",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 📞 CONTACT CARD
  Widget contactCard({
    required BuildContext context,
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required String actionText,
    required VoidCallback onTap,
  }) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),

      child: Container(
        padding: EdgeInsets.all(w * 0.04),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),

        child: Row(
          children: [
            /// ICON
            Container(
              height: w * 0.14,
              width: w * 0.14,
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
                size: w * 0.07,
              ),
            ),

            SizedBox(width: w * 0.04),

            /// TEXT
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: w * 0.045,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                  ),

                  SizedBox(height: h * 0.005),

                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      fontSize: w * 0.035,
                      color: AppColors.textGrey,
                    ),
                  ),

                  SizedBox(height: h * 0.008),

                  Text(
                    actionText,
                    style: GoogleFonts.inter(
                      fontSize: w * 0.038,
                      fontWeight: FontWeight.w600,
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
