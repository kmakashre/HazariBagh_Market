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
      backgroundColor: const Color(0xFFF3F4F6),
      body: SafeArea(
        child: Column(
          children: [

            const TopHeader(),

            SizedBox(height: h * 0.01),

            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: w * 0.04,
                  vertical: h * 0.015,
                ),
                children: const [
                  OrderCard(
                    orderId: "#K86ZHT1KZ",
                    date: "8 December 2025 | 05:45 PM",
                    productKey: "basmatiRice",
                    qty: 1,
                    price: "₹490",
                    statusKey: "pending",
                    statusColor: Colors.orange,
                    image: "assets/images/electronics.jpg",
                  ),
                  OrderCard(
                    orderId: "#K86ZHT1KZ",
                    date: "8 December 2025 | 05:45 PM",
                    productKey: "soyabinOil",
                    qty: 1,
                    price: "₹240",
                    statusKey: "completed",
                    statusColor: Colors.green,
                    image: "assets/images/clothe.jpg",
                  ),
                  OrderCard(
                    orderId: "#K86ZHT1KZ",
                    date: "8 December 2025 | 05:45 PM",
                    productKey: "biscuit",
                    qty: 1,
                    price: "₹40",
                    statusKey: "cancelled",
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
