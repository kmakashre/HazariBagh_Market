import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hazari_bagh_market/screen/orders/order_details_screen.dart';

class OrderCard extends StatelessWidget {
  final String orderId;
  final String date;
  final String productName;
  final String qty;
  final String price;
  final String status;
  final Color statusColor;
  final String image;

  const OrderCard({
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

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.only(bottom: h * 0.015),
      padding: EdgeInsets.all(w * 0.03),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(w * 0.03),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            spreadRadius: 1,
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// 🧾 ORDER HEADER
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Order $orderId",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: w * 0.035,
                ),
              ),
              Text(
                status,
                style: GoogleFonts.inter(
                  color: statusColor,
                  fontWeight: FontWeight.w600,
                  fontSize: w * 0.032,
                ),
              ),
            ],
          ),

          SizedBox(height: h * 0.003),

          Text(
            date,
            style: GoogleFonts.inter(
              fontSize: w * 0.03,
              color: Colors.grey,
            ),
          ),

          Divider(),

          /// 🛍 PRODUCT ROW
          Row(
            children: [

              /// PRODUCT IMAGE
              ClipRRect(
                borderRadius: BorderRadius.circular(w * 0.02),
                child: Image.asset(
                  image,
                  height: h * 0.07,
                  width: w * 0.15,
                  fit: BoxFit.cover,
                ),
              ),

              SizedBox(width: w * 0.03),

              /// PRODUCT INFO
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: w * 0.035,
                      ),
                    ),
                    SizedBox(height: h * 0.004),
                    Text(
                      qty,
                      style: GoogleFonts.inter(
                        fontSize: w * 0.03,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              /// 👉 VIEW DETAILS
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderDetailsScreen(
                        orderId: orderId,
                        date: date,
                        productName: productName,
                        qty: qty,
                        price: price,
                        status: status,
                        statusColor: statusColor,
                        image: image,
                      ),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Text(
                      "View Details",
                      style: GoogleFonts.inter(
                        fontSize: w * 0.03,
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: w * 0.028,
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
