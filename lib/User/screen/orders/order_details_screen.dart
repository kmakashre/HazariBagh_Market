import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../categories/TrackOrderScreen.dart';

class OrderDetailsScreen extends StatelessWidget {
  final String orderId;
  final String date;
  final String productName;
  final String qty;
  final String price;
  final String status;
  final Color statusColor;
  final String image;

  const OrderDetailsScreen({
    super.key,
    required this.orderId,
    required this.date,
    required this.productName,
    required this.qty,
    required this.price,
    required this.status,
    required this.statusColor,
    required this.image,
  });

  static const Color primaryColor = Color(0xFF3670A3);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      /// 🔝 APP BAR
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          "Order Details",
          style: GoogleFonts.inter(
            fontSize: w * 0.045,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(w * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// 🖼 PRODUCT IMAGE
            Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(w * 0.04),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: w * 0.02,
                      offset: Offset(0, h * 0.005),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(w * 0.04),
                  child: Image.asset(
                    image,
                    height: h * 0.25,
                    width: w * 0.7,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            SizedBox(height: h * 0.035),

            /// 📦 ORDER DETAILS CARD
            Container(
              padding: EdgeInsets.all(w * 0.045),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(w * 0.04),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// ORDER ID + STATUS
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Order #$orderId",
                        style: GoogleFonts.inter(
                          fontSize: w * 0.045,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      /// STATUS CHIP
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: w * 0.03,
                          vertical: h * 0.006,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(w * 0.06),
                        ),
                        child: Text(
                          status,
                          style: GoogleFonts.inter(
                            fontSize: w * 0.035,
                            fontWeight: FontWeight.w600,
                            color: statusColor,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: h * 0.008),

                  /// DATE
                  Text(
                    date,
                    style: GoogleFonts.inter(
                      fontSize: w * 0.032,
                      color: Colors.grey,
                    ),
                  ),

                  SizedBox(height: h * 0.025),
                  Divider(thickness: 1),
                  SizedBox(height: h * 0.02),

                  /// PRODUCT INFO
                  _infoRow("Product", productName, w),
                  _infoRow("Quantity", qty, w),
                  _infoRow("Price", price, w),
                ],
              ),
            ),

            SizedBox(height: h * 0.05),

            /// 🔵 TRACK ORDER BUTTON
            SizedBox(
              width: double.infinity,
              height: h * 0.065,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(w * 0.04),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TrackOrderScreen(),
                    ),
                  );
                },
                child: Text(
                  "Track Order",
                  style: GoogleFonts.inter(
                    fontSize: w * 0.045,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 INFO ROW
  Widget _infoRow(String title, String value, double w) {
    return Padding(
      padding: EdgeInsets.only(bottom: w * 0.035),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: w * 0.038,
              color: Colors.grey.shade600,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: w * 0.04,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
