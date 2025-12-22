import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../widgets/top_header.dart';
import '../../../provider/cart_provider.dart';

class RestaurantDetailsScreen extends StatelessWidget {
  final String img;
  final String name;
  final String type;
  final String rating;
  final String time;
  final String distance;

  const RestaurantDetailsScreen({
    super.key,
    required this.img,
    required this.name,
    required this.type,
    required this.rating,
    required this.time,
    required this.distance,
  });

  static const Color themeColor = Color(0xFFD0B5B5);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const TopHeader(),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(height: mq.height * 0.02),

                  ///  BACK BUTTON (arrow + text both clickable)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: mq.width * 0.04),
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      borderRadius: BorderRadius.circular(8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.arrow_back,
                              color: themeColor,
                              size: mq.width * 0.06),
                          SizedBox(width: mq.width * 0.02),
                          Text(
                            "Back",
                            style: TextStyle(
                              fontSize: mq.width * 0.045,
                              color: themeColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: mq.height * 0.015),

                  /// 🏪 RESTAURANT DETAILS
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: mq.width * 0.04),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(14)),
                            child: Image.asset(
                              img,
                              height: mq.height * 0.25,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name,
                                  style: TextStyle(
                                    fontSize: mq.width * 0.055,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 6),

                                Text(
                                  type,
                                  style: TextStyle(
                                    fontSize: mq.width * 0.035,
                                    color: Colors.grey,
                                  ),
                                ),

                                const SizedBox(height: 12),

                                Row(
                                  children: [
                                    const Icon(Icons.star,
                                        color: Colors.orange),
                                    const SizedBox(width: 5),
                                    Text(rating),

                                    const SizedBox(width: 20),

                                    const Icon(Icons.timer, color: Colors.grey),
                                    const SizedBox(width: 5),
                                    Text(time),

                                    const SizedBox(width: 20),

                                    const Icon(Icons.location_on,
                                        color: Colors.red),
                                    const SizedBox(width: 5),
                                    Text(distance),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: mq.height * 0.03),

                  /// 📋 MENU TITLE
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: mq.width * 0.04),
                    child: Text(
                      "Menu",
                      style: TextStyle(
                        fontSize: mq.width * 0.06,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  /// 🍽 MENU ITEMS
                  _menuItem(context, mq, "Chicken Biryani", "220"),
                  _menuItem(context, mq, "Veg Biryani", "180"),
                  _menuItem(context, mq, "Butter Chicken", "280"),
                  _menuItem(context, mq, "Paneer Tikka", "240"),

                  SizedBox(height: mq.height * 0.08),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🍽 MENU ITEM CARD
  Widget _menuItem(
      BuildContext context, Size mq, String title, String price) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: mq.width * 0.04, vertical: 6),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            )
          ],
        ),
        child: Row(
          children: [

            /// 🖼 PRODUCT IMAGE
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                img,
                width: mq.width * 0.20,
                height: mq.width * 0.20,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(width: 12),

            /// 📝 DETAILS
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: mq.width * 0.045,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    "Authentic & delicious",
                    style: TextStyle(
                      fontSize: mq.width * 0.033,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    "₹$price",
                    style: TextStyle(
                      fontSize: mq.width * 0.045,
                      fontWeight: FontWeight.bold,
                      color: themeColor,
                    ),
                  ),
                ],
              ),
            ),

            /// 🛒 ADD TO CART
            InkWell(
              onTap: () {
                Provider.of<CartProvider>(context, listen: false).addItem({
                  "name": title,
                  "price": double.parse(price),
                  "qty": 1,
                  "image": img,
                  "store": name, // ✅ restaurant wise cart
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("$title added to cart")),
                );
              },
              child: Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: themeColor.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "Add",
                  style: TextStyle(
                    color: themeColor,
                    fontWeight: FontWeight.bold,
                    fontSize: mq.width * 0.035,
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
