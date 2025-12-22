import 'package:flutter/material.dart';
import 'package:hazari_bagh_market/screen/categories/TrackOrderScreen.dart';
import 'package:hazari_bagh_market/screen/home/home_screen.dart';
import '../../widgets/top_header.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  static const Color primaryColor = Color(0xFF3670A3);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Column(
        children: [
          const TopHeader(),

          /// 🔙 BACK + TITLE
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: w * 0.02,
              vertical: h * 0.005,
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
                    Icons.keyboard_backspace_outlined,
                    size: w * 0.06,
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
            padding: EdgeInsets.symmetric(horizontal: w * 0.04),
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
              children: [
                _notificationCard(
                  context: context,
                  w: w,
                  image: "assets/images/clothe.jpg",
                  transactionId: "A23B567K",
                  date: "22/09/32",
                  status: "Out for Delivery",
                  price: "₹12,000",
                ),
                _notificationCard(
                  context: context,
                  w: w,
                  image: "assets/images/clothe.jpg",
                  transactionId: "A23B567K",
                  date: "22/09/32",
                  status: "Out for Delivery",
                  price: "₹15,000",
                ),
                _notificationCard(
                  context: context,
                  w: w,
                  image: "assets/images/clothe.jpg",
                  transactionId: "A23B567K",
                  date: "22/09/32",
                  status: "Out for Delivery",
                  price: "₹18,000",
                ),
                _notificationCard(
                  context: context,
                  w: w,
                  image: "assets/images/clothe.jpg",
                  transactionId: "A23B567K",
                  date: "22/09/32",
                  status: "Out for Delivery",
                  price: "₹9,000",
                ),
                _notificationCard(
                  context: context,
                  w: w,
                  image: "assets/images/clothe.jpg",
                  transactionId: "A23B567K",
                  date: "22/09/32",
                  status: "Out for Delivery",
                  price: "₹10,000",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 🔔 SINGLE NOTIFICATION CARD
  static Widget _notificationCard({
    required BuildContext context,
    required double w,
    required String image,
    required String transactionId,
    required String date,
    required String status,
    required String price,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: w * 0.03),
      padding: EdgeInsets.all(w * 0.03),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(w * 0.04),
      ),
      child: Row(
        children: [
          /// 🖼 IMAGE
          ClipRRect(
            borderRadius: BorderRadius.circular(w * 0.02),
            child: Image.asset(
              image,
              height: w * 0.13,
              width: w * 0.13,
              fit: BoxFit.cover,
            ),
          ),

          SizedBox(width: w * 0.03),

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
                    color: Colors.orange,
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

          /// 🚚 TRACK ORDER BUTTON
          SizedBox(
            height: w * 0.08,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                padding:
                EdgeInsets.symmetric(horizontal: w * 0.025),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(w * 0.02),
                ),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_)=>TrackOrderScreen()));
              },
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
