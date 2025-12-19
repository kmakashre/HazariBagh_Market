import 'package:flutter/material.dart';
import 'package:hazari_bagh_market/widgets/top_header.dart';
import '../../l10n/app_localizations.dart';
import 'contact_us_screen.dart';
import 'faq_screen.dart';
import 'live_chat_screen.dart';
import 'raise_complaint_screen.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({super.key});

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  int selectedIndex = 0;

  static const Color primaryColor = Color(0xFF3670A3);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TopHeader(),

          SizedBox(height: h * 0.015),

          /// 🔵 SUPPORT TABS
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: w * 0.03),
            child: Row(
              children: [
                _tabButton(loc.supportContactUs, 0, w, h),
                SizedBox(width: w * 0.025),
                _tabButton(loc.supportLiveChat, 1, w, h),
                SizedBox(width: w * 0.025),
                _tabButton(loc.supportFaqs, 2, w, h),
                SizedBox(width: w * 0.025),
                _tabButton(loc.supportRaiseComplaint, 3, w, h),
              ],
            ),
          ),

          SizedBox(height: h * 0.02),

          /// 🔽 TAB CONTENT
          Expanded(
            child: IndexedStack(
              index: selectedIndex,
              children: [
                const ContactUsScreen(),
                LiveChatScreen(),
                FaqScreenUpdated(),
                const RaiseComplaintScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 🟦 TAB BUTTON
  Widget _tabButton(String title, int index, double w, double h) {
    final bool isSelected = selectedIndex == index;

    return InkWell(
      borderRadius: BorderRadius.circular(w * 0.03),
      onTap: () => setState(() => selectedIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: EdgeInsets.symmetric(
          horizontal: w * 0.045,
          vertical: h * 0.012,
        ),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(w * 0.03),
          boxShadow: isSelected
              ? []
              : [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: w * 0.03,
              offset: Offset(0, h * 0.004),
            ),
          ],
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: w * 0.036,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }
}
