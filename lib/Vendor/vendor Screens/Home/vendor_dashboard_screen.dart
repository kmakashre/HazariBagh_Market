import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class VendorDashboardScreen extends StatelessWidget {
  const VendorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    ///  COLORS
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(w * 0.045),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 👋 HEADER
            Text(
              "Welcome Back 👋",
              style: TextStyle(
                fontSize: w * 0.052,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            SizedBox(height: h * 0.006),
            Text(
              "Here is your business overview",
              style: TextStyle(
                fontSize: w * 0.035,
                color: subTextColor,
              ),
            ),

            SizedBox(height: h * 0.03),

            /// 📊 STATS (4 IN ONE ROW)
            Row(
              children: [
                _statCard(
                  w,
                  title: "Orders",
                  value: "24",
                  icon: Icons.shopping_cart,
                  color: Colors.blue,
                  cardColor: cardColor,
                  textColor: textColor,
                  subTextColor: subTextColor,
                  shadowColor: shadowColor,
                ),
                _statCard(
                  w,
                  title: "Revenue",
                  value: "₹1.2k",
                  icon: Icons.currency_rupee,
                  color: Colors.green,
                  cardColor: cardColor,
                  textColor: textColor,
                  subTextColor: subTextColor,
                  shadowColor: shadowColor,
                ),
                _statCard(
                  w,
                  title: "Products",
                  value: "38",
                  icon: Icons.inventory_2,
                  color: Colors.orange,
                  cardColor: cardColor,
                  textColor: textColor,
                  subTextColor: subTextColor,
                  shadowColor: shadowColor,
                ),
                _statCard(
                  w,
                  title: "Rating",
                  value: "4.6",
                  icon: Icons.star,
                  color: Colors.purple,
                  cardColor: cardColor,
                  textColor: textColor,
                  subTextColor: subTextColor,
                  shadowColor: shadowColor,
                ),
              ],
            ),

            SizedBox(height: h * 0.04),

            /// 📊 SALES ANALYTICS
            Text(
              "Weekly Sales",
              style: TextStyle(
                fontSize: w * 0.046,
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
            ),

            SizedBox(height: h * 0.02),

            Container(
              height: h * 0.28,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: shadowColor,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: BarChart(
                _barChartData(isDark),
              ),
            ),

            SizedBox(height: h * 0.04),

            /// 🧾 LATEST ORDERS
            Text(
              "Latest Orders",
              style: TextStyle(
                fontSize: w * 0.046,
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
            ),

            SizedBox(height: h * 0.02),

            _latestOrderTile(
              "Order #1023",
              "₹320",
              "Delivered",
              cardColor,
              shadowColor,
              textColor,
            ),
            _latestOrderTile(
              "Order #1022",
              "₹450",
              "Pending",
              cardColor,
              shadowColor,
              textColor,
            ),
            _latestOrderTile(
              "Order #1021",
              "₹180",
              "Cancelled",
              cardColor,
              shadowColor,
              textColor,
            ),
          ],
        ),
      ),
    );
  }

  /// 📊 BAR CHART DATA
  BarChartData _barChartData(bool isDark) {
    return BarChartData(
      alignment: BarChartAlignment.spaceAround,
      maxY: 5000,
      gridData: FlGridData(show: false),
      borderData: FlBorderData(show: false),
      barTouchData: BarTouchData(enabled: true),
      titlesData: FlTitlesData(
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              const days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
              return Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  days[value.toInt()],
                  style: TextStyle(
                    color: isDark
                        ? Colors.grey.shade400
                        : Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              );
            },
          ),
        ),
      ),
      barGroups: [
        _barGroup(0, 1800),
        _barGroup(1, 2200),
        _barGroup(2, 1500),
        _barGroup(3, 3200),
        _barGroup(4, 2800),
        _barGroup(5, 4100),
        _barGroup(6, 3600),
      ],
    );
  }

  BarChartGroupData _barGroup(int x, double value) {
    /// 🎨 Dynamic color based on sales value
    LinearGradient gradient;

    if (value >= 3500) {
      gradient = const LinearGradient(
        colors: [Color(0xFF22C55E), Color(0xFF16A34A)], // Green
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );
    } else if (value >= 2500) {
      gradient = const LinearGradient(
        colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)], // Blue
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );
    } else {
      gradient = const LinearGradient(
        colors: [Color(0xFFF97316), Color(0xFFEA580C)], // Orange
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );
    }

    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: value,
          width: 18, // Thicker bar
          borderRadius: BorderRadius.circular(10), // Smooth curve
          gradient: gradient,

          /// ✨ Shadow / highlight effect
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 5000,
            color: Colors.grey.withOpacity(0.08),
          ),
        ),
      ],
    );
  }

  /// 📊 STAT CARD
  Widget _statCard(
      double w, {
        required String title,
        required String value,
        required IconData icon,
        required Color color,
        required Color cardColor,
        required Color textColor,
        required Color subTextColor,
        required Color shadowColor,
      }) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: w * 0.008),
        padding: EdgeInsets.all(w * 0.025),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(14),
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
            Align(
              alignment: Alignment.topRight,
              child: CircleAvatar(
                radius: 14,
                backgroundColor: color.withOpacity(0.18),
                child: Icon(icon, color: color, size: 14),
              ),
            ),
            SizedBox(height: w * 0.015),
            Text(
              value,
              style: TextStyle(
                fontSize: w * 0.036,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            SizedBox(height: w * 0.004),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: w * 0.025,
                color: subTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🧾 ORDER TILE
  Widget _latestOrderTile(
      String orderId,
      String amount,
      String status,
      Color cardColor,
      Color shadowColor,
      Color textColor,
      ) {
    final statusColor = status == "Delivered"
        ? Colors.green
        : status == "Pending"
        ? Colors.orange
        : Colors.red;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                orderId,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                amount,
                style: TextStyle(
                  color: textColor.withOpacity(0.6),
                ),
              ),
            ],
          ),
          Text(
            status,
            style: TextStyle(
              color: statusColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
