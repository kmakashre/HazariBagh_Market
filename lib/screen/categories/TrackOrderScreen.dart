import 'package:flutter/material.dart';
import 'package:hazari_bagh_market/colors/AppColors.dart';
import '../../widgets/top_header.dart';

class TrackOrderScreen extends StatelessWidget {
  const TrackOrderScreen({super.key});

  static const Color primaryColor = Color(0xFF3670A3);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [

          /// 🔵 FIXED TOP HEADER (NO SAFEAREA ISSUE)
          const TopHeader(),

          /// 🔽 SCROLLABLE CONTENT
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: h * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// 🔙 BACK BUTTON
                  Padding(
                    padding: EdgeInsets.only(
                      left: w * 0.04,
                      right: w * 0.04,
                      top: h * 0.01,
                      bottom: h * 0.015,
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () => Navigator.pop(context),
                      child: Row(
                        children: [
                          Icon(Icons.arrow_back,
                              color: primaryColor, size: w * 0.055),
                          SizedBox(width: w * 0.02),
                          Text(
                            "Back",
                            style: TextStyle(
                              fontSize: w * 0.045,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// 🗺 MAP
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                    child: Container(
                      height: h * 0.25,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.grey.shade300,
                      ),
                      child: const Center(
                        child: Icon(Icons.map, size: 80, color: Colors.white),
                      ),
                    ),
                  ),

                  SizedBox(height: h * 0.02),

                  /// 🚴 DELIVERY PARTNER
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                    child: Container(
                      padding: EdgeInsets.all(w * 0.035),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: w * 0.06,
                            backgroundColor: Colors.grey,
                            child: Icon(Icons.person,
                                color: Colors.white, size: w * 0.06),
                          ),
                          SizedBox(width: w * 0.03),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Ankit Sharma",
                                  style: TextStyle(
                                    fontSize: w * 0.04,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Delivery Partner",
                                  style: TextStyle(
                                    fontSize: w * 0.032,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(Icons.call, color: primaryColor),
                          SizedBox(width: w * 0.03),
                          Icon(Icons.message, color: primaryColor),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: h * 0.025),

                  /// 📦 ORDER STATUS
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                    child: Container(
                      padding: EdgeInsets.all(w * 0.035),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Column(
                        children: [
                          StatusRow(
                            icon: Icons.check_circle,
                            title: "Order Confirmed",
                            subtitle: "22 Aug 2023",
                            active: true,
                          ),
                          StatusRow(
                            icon: Icons.local_shipping,
                            title: "Out for delivery",
                            subtitle: "15–20 mins",
                            active: true,
                          ),
                          StatusRow(
                            icon: Icons.watch_later,
                            title: "Picked up",
                            subtitle: "Driver on way",
                            active: false,
                          ),
                          StatusRow(
                            icon: Icons.verified,
                            title: "Payment Verified",
                            subtitle: "Success",
                            active: false,
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: h * 0.03),

                  /// ❌ CANCEL BUTTON
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                    child: SizedBox(
                      width: double.infinity,
                      height: h * 0.065,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          "Cancel Order",
                          style: TextStyle(
                            fontSize: w * 0.04,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// ✅ ORDER STATUS ROW
class StatusRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool active;

  const StatusRow({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(
            icon,
            color: active ? Colors.green : Colors.grey,
            size: w * 0.06,
          ),
          SizedBox(width: w * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: w * 0.038,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: w * 0.032,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
