import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

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
    final w = mq.width;
    final h = mq.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [

          /// 🔝 HEADER
          const TopHeader(),

          /// 🔽 CONTENT
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(height: h * 0.02),

                  /// 🔙 BACK BUTTON
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      borderRadius: BorderRadius.circular(8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.arrow_back,
                              color: themeColor, size: w * 0.06),
                          SizedBox(width: w * 0.02),
                          Text(
                            "Back",
                            style: GoogleFonts.inter(
                              fontSize: w * 0.045,
                              fontWeight: FontWeight.w600,
                              color: themeColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: h * 0.015),

                  /// 🏪 RESTAURANT CARD
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          /// IMAGE
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(16)),
                            child: Image.asset(
                              img,
                              height: h * 0.26,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                /// NAME
                                Text(
                                  name,
                                  style: GoogleFonts.inter(
                                    fontSize: w * 0.055,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),

                                const SizedBox(height: 6),

                                /// TYPE
                                Text(
                                  type,
                                  style: GoogleFonts.inter(
                                    fontSize: w * 0.035,
                                    color: Colors.grey.shade600,
                                  ),
                                ),

                                const SizedBox(height: 12),

                                /// META INFO
                                Row(
                                  children: [
                                    const Icon(Icons.star,
                                        color: Colors.orange),
                                    const SizedBox(width: 4),
                                    Text(rating,
                                        style: GoogleFonts.inter()),

                                    const SizedBox(width: 18),

                                    const Icon(Icons.timer,
                                        color: Colors.grey),
                                    const SizedBox(width: 4),
                                    Text(time,
                                        style: GoogleFonts.inter()),

                                    const SizedBox(width: 18),

                                    const Icon(Icons.location_on,
                                        color: Colors.red),
                                    const SizedBox(width: 4),
                                    Text(distance,
                                        style: GoogleFonts.inter()),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: h * 0.03),

                  /// 📋 MENU TITLE
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                    child: Text(
                      "Menu",
                      style: GoogleFonts.inter(
                        fontSize: w * 0.06,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  /// 🍽 MENU ITEMS
                  _menuItem(context, mq, "Chicken Biryani", "220"),
                  _menuItem(context, mq, "Veg Biryani", "180"),
                  _menuItem(context, mq, "Butter Chicken", "280"),
                  _menuItem(context, mq, "Paneer Tikka", "240"),

                  SizedBox(height: h * 0.08),
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
    final w = mq.width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: 6),
      child: Container(
        padding: const EdgeInsets.all(12),
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

            /// IMAGE
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                img,
                width: w * 0.20,
                height: w * 0.20,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(width: 12),

            /// DETAILS
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: w * 0.045,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    "Authentic & delicious",
                    style: GoogleFonts.inter(
                      fontSize: w * 0.033,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    "₹$price",
                    style: GoogleFonts.inter(
                      fontSize: w * 0.045,
                      fontWeight: FontWeight.bold,
                      color: themeColor,
                    ),
                  ),
                ],
              ),
            ),

            /// ADD BUTTON
            InkWell(
              onTap: () {
                Provider.of<CartProvider>(context, listen: false).addItem({
                  "name": title,
                  "price": double.parse(price),
                  "qty": 1,
                  "image": img,
                  "store": name,
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
                  style: GoogleFonts.inter(
                    fontSize: w * 0.035,
                    fontWeight: FontWeight.w700,
                    color: themeColor,
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
