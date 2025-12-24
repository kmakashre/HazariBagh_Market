import 'package:flutter/material.dart';
import 'package:hazari_bagh_market/Vendor/vendor%20Screens/Home/vendor_offers_screen.dart';

class VendorDashboardScreen extends StatelessWidget {
  const VendorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    /// 🎨 COLORS
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

            /// 📊 STATS
            Row(
              children: [
                _statCardRow(w,
                    title: "Orders",
                    value: "24",
                    icon: Icons.shopping_cart,
                    color: Colors.blue,
                    cardColor: cardColor,
                    textColor: textColor,
                    subTextColor: subTextColor,
                    shadowColor: shadowColor),

                _statCardRow(w,
                    title: "Revenue",
                    value: "₹1.2k",
                    icon: Icons.currency_rupee,
                    color: Colors.green,
                    cardColor: cardColor,
                    textColor: textColor,
                    subTextColor: subTextColor,
                    shadowColor: shadowColor),

                _statCardRow(w,
                    title: "Products",
                    value: "38",
                    icon: Icons.inventory_2,
                    color: Colors.orange,
                    cardColor: cardColor,
                    textColor: textColor,
                    subTextColor: subTextColor,
                    shadowColor: shadowColor),

                _statCardRow(w,
                    title: "Rating",
                    value: "4.6",
                    icon: Icons.star,
                    color: Colors.purple,
                    cardColor: cardColor,
                    textColor: textColor,
                    subTextColor: subTextColor,
                    shadowColor: shadowColor),
              ],
            ),


            SizedBox(height: h * 0.015),

            Row(
              children: [
                _statCardRow(
                  w,
                  title: "Total Products",
                  value: "38",
                  icon: Icons.inventory_2,
                  color: Colors.orange,
                  cardColor: cardColor,
                  textColor: textColor,
                  subTextColor: subTextColor,
                  shadowColor: shadowColor,
                ),
                _statCardRow(
                  w,
                  title: "Store Rating",
                  value: "4.6 ⭐",
                  icon: Icons.star,
                  color: Colors.purple,
                  cardColor: cardColor,
                  textColor: textColor,
                  subTextColor: subTextColor,
                  shadowColor: shadowColor,
                ),
              ],
            ),


            SizedBox(height: h * 0.035),

            /// ⚡ QUICK ACTIONS
            Text(
              "Quick Actions",
              style: TextStyle(
                fontSize: w * 0.046,
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
            ),

            SizedBox(height: h * 0.02),

            Row(
              children: [
                _actionButton(
                  w,
                  icon: Icons.local_offer,
                  label: "Offers",
                  color: Colors.orange,
                  textColor: textColor,
                  isDark: isDark,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const VendorOffersScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),



            SizedBox(height: h * 0.035),

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

  Widget _statCardRow(
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
            /// ICON
            Align(
              alignment: Alignment.topRight,
              child: CircleAvatar(
                radius: 14,
                backgroundColor: color.withOpacity(0.18),
                child: Icon(icon, color: color, size: 14),
              ),
            ),

            SizedBox(height: w * 0.015),

            /// VALUE
            Text(
              value,
              style: TextStyle(
                fontSize: w * 0.036,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),

            SizedBox(height: w * 0.004),

            /// TITLE
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
        margin: EdgeInsets.all(w * 0.015),
        padding: EdgeInsets.all(w * 0.04),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(w * 0.05),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.18),
              child: Icon(icon, color: color),
            ),
            SizedBox(height: w * 0.03),
            Text(
              value,
              style: TextStyle(
                fontSize: w * 0.05,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            SizedBox(height: w * 0.01),
            Text(
              title,
              style: TextStyle(
                fontSize: w * 0.032,
                color: subTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ⚡ ACTION BUTTON
  Widget _actionButton(
      double w, {
        required IconData icon,
        required String label,
        required Color color,
        required Color textColor,
        required bool isDark,
        required VoidCallback onTap,
      }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(w * 0.05),
        child: Container(
          margin: EdgeInsets.all(w * 0.015),
          padding: EdgeInsets.symmetric(vertical: w * 0.045),
          decoration: BoxDecoration(
            color: color.withOpacity(isDark ? 0.25 : 0.12),
            borderRadius: BorderRadius.circular(w * 0.05),
          ),
          child: Column(
            children: [
              Icon(icon, size: w * 0.07, color: color),
              SizedBox(height: w * 0.02),
              Text(
                label,
                style: TextStyle(
                  fontSize: w * 0.035,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
            ],
          ),
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
