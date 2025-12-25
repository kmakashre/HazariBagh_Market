import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../VendorProvider/vendor_reports_provider.dart';
import '../models/report_model.dart';

class VendorReportsScreen extends StatelessWidget {
  const VendorReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final provider = context.watch<VendorReportsProvider>();

    final bgColor =
    isDark ? const Color(0xFF0F172A) : const Color(0xFFF6F8FC);
    final cardColor =
    isDark ? const Color(0xFF1E293B) : Colors.white;
    final textColor =
    isDark ? Colors.white : const Color(0xFF1F2937);
    final subTextColor =
    isDark ? Colors.grey.shade400 : Colors.grey.shade600;
    final shadowColor =
    isDark ? Colors.black.withOpacity(0.35) : Colors.black.withOpacity(0.08);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(w * 0.045),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Reports & Analytics",
                  style: TextStyle(
                    fontSize: w * 0.055,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),

                SizedBox(height: h * 0.02),

                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: provider.summaryCards.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: w > 600 ? 4 : 2,
                    crossAxisSpacing: w * 0.03,
                    mainAxisSpacing: h * 0.02,
                    childAspectRatio: w > 600 ? 1.6 : 1.3,
                  ),
                  itemBuilder: (_, index) {
                    final ReportModel item =
                    provider.summaryCards[index];

                    return ReportCard(
                      title: item.title,
                      value: item.value,
                        icon: item.icon,

                      color: Color(item.colorCode),
                      cardColor: cardColor,
                      textColor: textColor,
                      subTextColor: subTextColor,
                      shadowColor: shadowColor,
                      w: w,
                    );
                  },
                ),

                SizedBox(height: h * 0.035),

                Text(
                  "Sales Summary",
                  style: TextStyle(
                    fontSize: w * 0.045,
                    fontWeight: FontWeight.w700,
                    color: textColor,
                  ),
                ),

                SizedBox(height: h * 0.015),

                Container(
                  padding: EdgeInsets.all(w * 0.045),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: shadowColor,
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Column(
                    children: provider.salesSummary.entries.map((e) {
                      return SummaryRow(
                        title: e.key,
                        value: e.value,
                      );
                    }).toList(),
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

/// ✅ PUBLIC REPORT CARD
class ReportCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final Color cardColor;
  final Color textColor;
  final Color subTextColor;
  final Color shadowColor;
  final double w;

  const ReportCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.cardColor,
    required this.textColor,
    required this.subTextColor,
    required this.shadowColor,
    required this.w,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(w * 0.035),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.15),
            child: Icon(icon, color: color),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: w * 0.045,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: w * 0.032,
              color: subTextColor,
            ),
          ),
        ],
      ),
    );
  }
}

/// ✅ PUBLIC SUMMARY ROW
class SummaryRow extends StatelessWidget {
  final String title;
  final String value;

  const SummaryRow({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final textColor =
    Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black87;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: w * 0.015),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(
                  fontWeight: FontWeight.w600, color: textColor)),
          Text(value,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: textColor)),
        ],
      ),
    );
  }
}
