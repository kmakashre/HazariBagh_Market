import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/cart_provider.dart';
import '../../cart/cart_page.dart';

class AddToCartScreen extends StatelessWidget {
  final String itemName;
  final String itemPrice;
  final String itemImage;

  const AddToCartScreen({
    super.key,
    required this.itemName,
    required this.itemPrice,
    required this.itemImage,
  });

  static const Color themeColor = Color(0xFFD0B5B5);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,

      ///  APP BAR
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Text(
          "Add To Cart",
          style: TextStyle(
            color: Colors.black,
            fontSize: w * 0.05,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),

      body: Padding(
        padding: EdgeInsets.all(w * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// 🖼 PRODUCT IMAGE
            ClipRRect(
              borderRadius: BorderRadius.circular(w * 0.04),
              child: Image.asset(
                itemImage,
                height: h * 0.28,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(height: h * 0.025),

            /// 📛 PRODUCT NAME
            Text(
              itemName,
              style: TextStyle(
                fontSize: w * 0.055,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            SizedBox(height: h * 0.012),

            /// 💰 PRICE
            Text(
              "₹$itemPrice",
              style: TextStyle(
                fontSize: w * 0.05,
                color: themeColor,
                fontWeight: FontWeight.w600,
              ),
            ),

            const Spacer(),

            /// 🛒 ADD TO CART BUTTON
            ElevatedButton(
              onPressed: () {
                Provider.of<CartProvider>(
                  context,
                  listen: false,
                ).addItem({
                  "name": itemName,
                  "price": double.parse(itemPrice),
                  "image": itemImage,
                  "qty": 1,
                  "store": "Fashion Hub",
                });

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CartScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, h * 0.065),
                backgroundColor: themeColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(w * 0.04),
                ),
              ),
              child: Text(
                "Add to Cart",
                style: TextStyle(
                  fontSize: w * 0.045,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
