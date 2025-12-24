import 'package:flutter/material.dart';

class VendorOrdersScreen extends StatelessWidget {
  const VendorOrdersScreen({super.key});

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🧾 TITLE
            Text(
              "Orders",
              style: TextStyle(
                fontSize: w * 0.055,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),

            const SizedBox(height: 16),

            /// 📦 ORDER LIST
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return _orderCard(
                    w,
                    cardColor,
                    textColor,
                    subTextColor,
                    shadowColor,
                    isDark,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _orderCard(
      double w,
      Color cardColor,
      Color textColor,
      Color subTextColor,
      Color shadowColor,
      bool isDark,
      ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
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
          /// 👤 CUSTOMER + STATUS
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Customer: Rahul Sharma",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: w * 0.038,
                  color: textColor,
                ),
              ),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(isDark ? 0.25 : 0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "Pending",
                  style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          /// 🛒 ORDER DETAILS
          Text(
            "Order ID: #ORD1023",
            style: TextStyle(color: subTextColor),
          ),

          const SizedBox(height: 6),

          Text(
            "Amount: ₹450",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: w * 0.04,
              color: textColor,
            ),
          ),

          const SizedBox(height: 14),

          /// 🔘 ACTION BUTTONS
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text("Accept"),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text("Reject"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
