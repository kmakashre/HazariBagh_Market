import 'package:flutter/material.dart';

class VendorReportsScreen extends StatelessWidget {
  const VendorReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

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
      body: Padding(
        padding: EdgeInsets.all(w * 0.04),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 📊 TITLE
              Text(
                "Reports & Analytics",
                style: TextStyle(
                  fontSize: w * 0.055,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),

              const SizedBox(height: 16),

              /// 💰 SUMMARY CARDS
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.3,
                children: [
                  _ReportCard(
                    title: "Total Sales",
                    value: "₹52,340",
                    icon: Icons.currency_rupee,
                    color: Colors.green,
                    cardColor: cardColor,
                    textColor: textColor,
                    subTextColor: subTextColor,
                    shadowColor: shadowColor,
                  ),
                  _ReportCard(
                    title: "Total Orders",
                    value: "1,245",
                    icon: Icons.shopping_cart,
                    color: Colors.blue,
                    cardColor: cardColor,
                    textColor: textColor,
                    subTextColor: subTextColor,
                    shadowColor: shadowColor,
                  ),
                  _ReportCard(
                    title: "Today Revenue",
                    value: "₹1,280",
                    icon: Icons.today,
                    color: Colors.orange,
                    cardColor: cardColor,
                    textColor: textColor,
                    subTextColor: subTextColor,
                    shadowColor: shadowColor,
                  ),
                  _ReportCard(
                    title: "Monthly Revenue",
                    value: "₹18,900",
                    icon: Icons.bar_chart,
                    color: Colors.purple,
                    cardColor: cardColor,
                    textColor: textColor,
                    subTextColor: subTextColor,
                    shadowColor: shadowColor,
                  ),
                ],
              ),

              const SizedBox(height: 24),

              /// 📈 SALES SUMMARY
              Text(
                "Sales Summary",
                style: TextStyle(
                  fontSize: w * 0.045,
                  fontWeight: FontWeight.w700,
                  color: textColor,
                ),
              ),

              const SizedBox(height: 12),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: shadowColor,
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SummaryRow(
                      title: "Today Orders",
                      value: "24",
                      textColor: textColor,
                    ),
                    _SummaryRow(
                      title: "Completed Orders",
                      value: "1,180",
                      textColor: textColor,
                    ),
                    _SummaryRow(
                      title: "Cancelled Orders",
                      value: "65",
                      textColor: textColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 🔹 REPORT CARD
class _ReportCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final Color cardColor;
  final Color textColor;
  final Color subTextColor;
  final Color shadowColor;

  const _ReportCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.cardColor,
    required this.textColor,
    required this.subTextColor,
    required this.shadowColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 6,
            offset: const Offset(0, 3),
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
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 13,
              color: subTextColor,
            ),
          ),
        ],
      ),
    );
  }
}

/// 🔹 SUMMARY ROW
class _SummaryRow extends StatelessWidget {
  final String title;
  final String value;
  final Color textColor;

  const _SummaryRow({
    required this.title,
    required this.value,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
