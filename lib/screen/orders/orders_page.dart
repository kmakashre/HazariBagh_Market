import 'package:flutter/material.dart';
import 'package:hazari_bagh_market/widgets/top_header.dart';
import 'order_card.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),

      body: SafeArea(
        child: Column(
          children: [

            /// 🔝 TOP HEADER
            const TopHeader(),

            SizedBox(height: h * 0.015),

            /// 📦 ORDERS LIST
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: w * 0.035,
                  vertical: h * 0.01,
                ),
                children: const [

                  /// 🟧 PENDING ORDER
                  OrderCard(
                    orderId: "#K86ZHT1KZ",
                    date: "Placed on 8 December 2025 at 05:45 PM",
                    productName: "Basmati Rice 5kg",
                    qty: "Qty: 1",
                    price: "₹490",
                    status: "Pending",
                    statusColor: Colors.orange,
                    image: "assets/images/electronics.jpg",
                  ),

                  /// 🟩 COMPLETED ORDER
                  OrderCard(
                    orderId: "#K86ZHT1KZ",
                    date: "Placed on 8 December 2025 at 05:45 PM",
                    productName: "Soyabin Oil",
                    qty: "Qty: 1",
                    price: "₹240",
                    status: "Completed",
                    statusColor: Colors.green,
                    image: "assets/images/clothe.jpg",
                  ),

                  /// 🟥 CANCELLED ORDER
                  OrderCard(
                    orderId: "#K86ZHT1KZ",
                    date: "Placed on 8 December 2025 at 05:45 PM",
                    productName: "Biscuit",
                    qty: "Qty: 1",
                    price: "₹40",
                    status: "Cancelled",
                    statusColor: Colors.red,
                    image: "assets/images/electronics.jpg",
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
