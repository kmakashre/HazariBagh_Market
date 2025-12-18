import 'package:flutter/material.dart';
import 'package:hazari_bagh_market/screen/home/home_screen.dart';
import '../../widgets/top_header.dart';
import 'All Categories/job/job_details_screen.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  static const Color primaryColor = Color(0xFF3670A3);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,

      body: SafeArea(
        child: Column(
          children: [

            /// 🔝 TOP HEADER
            const TopHeader(),

            /// 🔙 BACK + TITLE
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: w * 0.03,
                vertical: h * 0.01,
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const HomeScreen(),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      size: w * 0.055,
                    ),
                  ),
                  Text(
                    "Notifications",
                    style: TextStyle(
                      fontSize: w * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            /// 📅 TODAY + MARK AS READ
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.06),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Today",
                    style: TextStyle(
                      fontSize: w * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Mark as read",
                    style: TextStyle(
                      fontSize: w * 0.035,
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: h * 0.015),

            /// 🔔 NOTIFICATION LIST
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(w * 0.04),
                children: const [
                  _NotificationCard(
                    image: "assets/images/clothe.jpg",
                    transactionId: "A23B567K",
                    date: "22/09/25",
                    status: "Out for Delivery",
                    price: "₹12,000",
                  ),
                  _NotificationCard(
                    image: "assets/images/clothe.jpg",
                    transactionId: "B45T892X",
                    date: "22/09/25",
                    status: "Delivered",
                    price: "₹15,000",
                  ),
                  _NotificationCard(
                    image: "assets/images/clothe.jpg",
                    transactionId: "C89Y223M",
                    date: "21/09/25",
                    status: "Cancelled",
                    price: "₹18,000",
                  ),
                  _NotificationCard(
                    image: "assets/images/clothe.jpg",
                    transactionId: "D23L991A",
                    date: "20/09/25",
                    status: "Out for Delivery",
                    price: "₹9,000",
                  ),
                  _NotificationCard(
                    image: "assets/images/clothe.jpg",
                    transactionId: "E09P881Q",
                    date: "20/09/25",
                    status: "Delivered",
                    price: "₹10,000",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 🔔 SINGLE NOTIFICATION CARD
class _NotificationCard extends StatelessWidget {
  final String image;
  final String transactionId;
  final String date;
  final String status;
  final String price;

  const _NotificationCard({
    required this.image,
    required this.transactionId,
    required this.date,
    required this.status,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    Color statusColor = status == "Delivered"
        ? Colors.green
        : status == "Cancelled"
        ? Colors.red
        : Colors.orange;

    return Container(
      margin: EdgeInsets.only(bottom: w * 0.035),
      padding: EdgeInsets.all(w * 0.035),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(w * 0.04),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [

          /// 🖼 IMAGE
          ClipRRect(
            borderRadius: BorderRadius.circular(w * 0.025),
            child: Image.asset(
              image,
              height: w * 0.14,
              width: w * 0.14,
              fit: BoxFit.cover,
            ),
          ),

          SizedBox(width: w * 0.035),

          /// 📦 DETAILS
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Transaction ID : $transactionId",
                  style: TextStyle(
                    fontSize: w * 0.035,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: w * 0.01),
                Text(
                  "Scheduled for : $date",
                  style: TextStyle(
                    fontSize: w * 0.03,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: w * 0.01),
                Text(
                  status,
                  style: TextStyle(
                    fontSize: w * 0.032,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
                SizedBox(height: w * 0.005),
                Text(
                  price,
                  style: TextStyle(
                    fontSize: w * 0.035,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),

          /// 🚚 TRACK BUTTON
          SizedBox(
            height: w * 0.085,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                padding: EdgeInsets.symmetric(horizontal: w * 0.03),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(w * 0.02),
                ),
              ),
              onPressed: () {},
              child: Text(
                "Track",
                style: TextStyle(
                  fontSize: w * 0.03,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
