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
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final bgColor = isDark ? const Color(0xFF0F172A) : Colors.white;
    final cardColor = isDark ? const Color(0xFF1E293B) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final subTextColor =
    isDark ? Colors.grey.shade300 : Colors.grey.shade700;

    return Scaffold(
      backgroundColor: bgColor,

      /// 🔝 APP BAR
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0.6,
        title: Text(
          "Add To Cart",
          style: TextStyle(
            color: textColor,
            fontSize: w * 0.05,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: IconThemeData(color: textColor),
      ),

      body: Padding(
        padding: EdgeInsets.all(w * 0.045),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🖼 PRODUCT IMAGE
            Container(
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(w * 0.04),
                boxShadow: [
                  BoxShadow(
                    color: isDark ? Colors.black54 : Colors.black12,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(w * 0.04),
                child: Image.asset(
                  itemImage,
                  height: h * 0.28,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            SizedBox(height: h * 0.03),

            /// 📛 PRODUCT NAME
            Text(
              itemName,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: w * 0.055,
                fontWeight: FontWeight.bold,
                color: textColor,
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
            SizedBox(
              width: double.infinity,
              height: h * 0.065,
              child: ElevatedButton(
                onPressed: () {
                  context.read<CartProvider>().addItem({
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
                  backgroundColor: themeColor,
                  elevation: 4,
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
            ),
          ],
        ),
      ),
    );
  }
}
