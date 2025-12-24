import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../widgets/top_header.dart';
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
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;
    final loc = AppLocalizations.of(context);

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final bgColor = isDark ? const Color(0xFF0F172A) : Colors.white;
    final cardColor = isDark ? const Color(0xFF1E293B) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final subTextColor =
    isDark ? Colors.grey.shade400 : Colors.grey.shade600;

    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        children: [
          const TopHeader(),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: h * 0.02),

                  /// 🔙 BACK
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      borderRadius: BorderRadius.circular(8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.arrow_back,
                              color: textColor, size: w * 0.055),
                          SizedBox(width: w * 0.02),
                          Text(
                            loc.back,
                            style: TextStyle(
                              fontSize: w * 0.045,
                              color: textColor,
                              fontWeight: FontWeight.w600,
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
                        color: cardColor,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: isDark
                                ? Colors.black54
                                : Colors.black12,
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(16)),
                            child: Image.asset(
                              img,
                              height: h * 0.25,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name,
                                  style: TextStyle(
                                    fontSize: w * 0.055,
                                    fontWeight: FontWeight.bold,
                                    color: textColor,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  type,
                                  style: TextStyle(
                                    fontSize: w * 0.035,
                                    color: subTextColor,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    _iconText(Icons.star, rating,
                                        Colors.orange, w),
                                    SizedBox(width: w * 0.05),
                                    _iconText(Icons.timer, time,
                                        subTextColor, w),
                                    SizedBox(width: w * 0.05),
                                    _iconText(Icons.location_on, distance,
                                        Colors.redAccent, w),
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
                      loc.getByKey('menu'),
                      style: TextStyle(
                        fontSize: w * 0.06,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  _menuItem(context, w, loc.getByKey('chickenBiryani'), "220"),
                  _menuItem(context, w, loc.getByKey('vegBiryani'), "180"),
                  _menuItem(context, w, loc.getByKey('butterChicken'), "280"),
                  _menuItem(context, w, loc.getByKey('paneerTikka'), "240"),

                  SizedBox(height: h * 0.08),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🍽 MENU ITEM
  Widget _menuItem(
      BuildContext context, double w, String title, String price) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: 6),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E293B) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: isDark ? Colors.black54 : Colors.black12,
              blurRadius: 6,
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                img,
                width: w * 0.22,
                height: w * 0.22,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: w * 0.045)),
                  const SizedBox(height: 4),
                  Text("Authentic & delicious",
                      style: TextStyle(
                          fontSize: w * 0.032,
                          color: Colors.grey)),
                  const SizedBox(height: 6),
                  Text("₹$price",
                      style: TextStyle(
                          fontSize: w * 0.045,
                          fontWeight: FontWeight.bold,
                          color: themeColor)),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                context.read<CartProvider>().addItem({
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
                  color: themeColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "Add",
                  style: TextStyle(
                      color: themeColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _iconText(
      IconData icon, String text, Color color, double w) {
    return Row(
      children: [
        Icon(icon, size: w * 0.045, color: color),
        const SizedBox(width: 4),
        Text(text, style: TextStyle(fontSize: w * 0.035)),
      ],
    );
  }
}
