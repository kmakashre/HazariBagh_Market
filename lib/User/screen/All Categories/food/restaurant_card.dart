import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Model/restaurant_model.dart';
import '../../../../l10n/app_localizations.dart';
import 'RestaurantDetailsScreen.dart';

class RestaurantCard extends StatelessWidget {
  final RestaurantModel restaurant;

  const RestaurantCard({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;
    final loc = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final cardColor = isDark ? const Color(0xFF1E293B) : Colors.white;
    final titleColor = isDark ? Colors.white : Colors.black;
    final subTextColor =
    isDark ? Colors.grey.shade300 : Colors.grey.shade600;
    final iconGrey =
    isDark ? Colors.grey.shade400 : Colors.grey.shade700;

    return InkWell(
      borderRadius: BorderRadius.circular(w * 0.035),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => RestaurantDetailsScreen(
              img: restaurant.image,
              name: loc.getByKey(restaurant.nameKey),
              type: loc.getByKey(restaurant.typeKey),
              rating: restaurant.rating,
              time: restaurant.time,
              distance: restaurant.distance,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(w * 0.035),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(w * 0.035),
          boxShadow: [
            BoxShadow(
              color: isDark ? Colors.black54 : Colors.black12,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🖼 IMAGE
            ClipRRect(
              borderRadius: BorderRadius.circular(w * 0.03),
              child: Image.asset(
                restaurant.image,
                width: w * 0.23,
                height: w * 0.23,
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(width: w * 0.035),

            /// 📄 DETAILS
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 🍴 NAME
                  Text(
                    loc.getByKey(restaurant.nameKey),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: w * 0.048,
                      fontWeight: FontWeight.w700,
                      color: titleColor,
                    ),
                  ),

                  SizedBox(height: h * 0.004),

                  /// 🏷 TYPE
                  Text(
                    loc.getByKey(restaurant.typeKey),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: w * 0.035,
                      color: subTextColor,
                    ),
                  ),

                  SizedBox(height: h * 0.01),

                  /// ⭐ RATING & ⏱ TIME
                  Row(
                    children: [
                      Icon(Icons.star,
                          color: Colors.amber, size: w * 0.045),
                      const SizedBox(width: 4),
                      Text(
                        restaurant.rating,
                        style: GoogleFonts.inter(
                          fontSize: w * 0.035,
                          fontWeight: FontWeight.w600,
                          color: titleColor,
                        ),
                      ),

                      SizedBox(width: w * 0.04),

                      Icon(Icons.timer_outlined,
                          size: w * 0.045, color: iconGrey),
                      const SizedBox(width: 4),
                      Text(
                        restaurant.time,
                        style: GoogleFonts.inter(
                          fontSize: w * 0.035,
                          color: titleColor,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: h * 0.006),

                  /// 📍 DISTANCE
                  Row(
                    children: [
                      Icon(Icons.location_on,
                          color: Colors.redAccent,
                          size: w * 0.045),
                      const SizedBox(width: 4),
                      Text(
                        restaurant.distance,
                        style: GoogleFonts.inter(
                          fontSize: w * 0.035,
                          color: subTextColor,
                        ),
                      ),
                    ],
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
