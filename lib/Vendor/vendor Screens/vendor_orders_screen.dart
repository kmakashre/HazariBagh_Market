import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../VendorProvider/order_provider.dart';
import '../models/order_model.dart';

class VendorOrdersScreen extends StatelessWidget {
  const VendorOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    final isDark = Theme.of(context).brightness == Brightness.dark;

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

    final orderProvider = context.watch<OrderProvider>();

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(w * 0.045),
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

              SizedBox(height: h * 0.025),

              /// 📦 ORDER LIST
              Expanded(
                child: ListView.builder(
                  itemCount: orderProvider.orders.length,
                  itemBuilder: (context, index) {
                    final order = orderProvider.orders[index];
                    return _orderCard(
                      w: w,
                      h: h,
                      order: order,
                      cardColor: cardColor,
                      textColor: textColor,
                      subTextColor: subTextColor,
                      shadowColor: shadowColor,
                      isDark: isDark,
                      onAccept: () =>
                          orderProvider.acceptOrder(index),
                      onReject: () =>
                          orderProvider.rejectOrder(index),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _orderCard({
    required double w,
    required double h,
    required OrderModel order,
    required Color cardColor,
    required Color textColor,
    required Color subTextColor,
    required Color shadowColor,
    required bool isDark,
    required VoidCallback onAccept,
    required VoidCallback onReject,
  }) {
    final statusColor = order.status == "Delivered"
        ? Colors.green
        : order.status == "Pending"
        ? Colors.orange
        : Colors.red;

    return Container(
      margin: EdgeInsets.only(bottom: h * 0.02),
      padding: EdgeInsets.all(w * 0.04),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
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
          /// 👤 CUSTOMER + STATUS
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                order.customer,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: w * 0.038,
                  color: textColor,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: w * 0.035,
                  vertical: h * 0.006,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(isDark ? 0.25 : 0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  order.status,
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                    fontSize: w * 0.032,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: h * 0.012),

          Text(
            "Order ID: ${order.orderId}",
            style: TextStyle(
              color: subTextColor,
              fontSize: w * 0.032,
            ),
          ),

          SizedBox(height: h * 0.006),

          Text(
            order.amount,
            style: TextStyle(
              fontSize: w * 0.042,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),

          SizedBox(height: h * 0.02),

          /// ⚙ ACTION BUTTONS
          if (order.status == "Pending")
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onReject,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                      padding: EdgeInsets.symmetric(
                        vertical: h * 0.014,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      "Reject",
                      style: TextStyle(fontSize: w * 0.036),
                    ),
                  ),
                ),
                SizedBox(width: w * 0.03),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onAccept,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(
                        vertical: h * 0.014,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      "Accept",
                      style: TextStyle(
                        fontSize: w * 0.036,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
