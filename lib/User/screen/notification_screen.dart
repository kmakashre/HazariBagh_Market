import 'package:flutter/material.dart';
import '../../widgets/top_header.dart';
import '../../l10n/app_localizations.dart';
import 'categories/TrackOrderScreen.dart';
import 'home/home_screen.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  static const Color primaryColor = Color(0xFF3670A3);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final loc = AppLocalizations.of(context);

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
                  loc.getByKey('notifications'),
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
                  loc.getByKey('today'),
                  style: TextStyle(
                    fontSize: w * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  loc.getByKey('mark_as_read'),
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
                  status: loc.getByKey('out_for_delivery'),
                  price: "₹12,000",
                ),
                _notificationCard(
                  context: context,
                  w: w,
                  image: "assets/images/clothe.jpg",
                  transactionId: "A23B567K",
                  date: "22/09/32",
                  status: loc.getByKey('out_for_delivery'),
                  price: "₹15,000",
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
    final loc = AppLocalizations.of(context);

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
                  "${loc.getByKey('transaction_id')} : $transactionId",
                  style: TextStyle(
                    fontSize: w * 0.035,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: w * 0.01),
                Text(
                  "${loc.getByKey('scheduled_for')} : $date",
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

          /// 🚚 TRACK ORDER
          SizedBox(
            height: w * 0.08,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                padding: EdgeInsets.symmetric(horizontal: w * 0.025),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(w * 0.02),
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
                loc.getByKey('track'),
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
