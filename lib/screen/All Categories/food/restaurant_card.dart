import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'RestaurantDetailsScreen.dart';

class RestaurantCard extends StatelessWidget {
  final Size size;
  final String img;
  final String name;
  final String type;
  final String rating;
  final String time;
  final String distance;

  const RestaurantCard({
    super.key,
    required this.size,
    required this.img,
    required this.name,
    required this.type,
    required this.rating,
    required this.time,
    required this.distance,
  });

  @override
  Widget build(BuildContext context) {
    final w = size.width;
    final h = size.height;

    return InkWell(
      borderRadius: BorderRadius.circular(w * 0.035),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => RestaurantDetailsScreen(
              img: img,
              name: name,
              type: type,
              rating: rating,
              time: time,
              distance: distance,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(w * 0.035),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(w * 0.035),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            )
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// 🖼 IMAGE
            ClipRRect(
              borderRadius: BorderRadius.circular(w * 0.03),
              child: Image.asset(
                img,
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
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: w * 0.048,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),

                  SizedBox(height: h * 0.004),

                  /// 🏷 TYPE
                  Text(
                    type,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: w * 0.035,
                      color: Colors.grey.shade600,
                    ),
                  ),

                  SizedBox(height: h * 0.01),

                  /// ⭐ RATING & ⏱ TIME
                  Row(
                    children: [
                      Icon(Icons.star,
                          color: Colors.amber, size: w * 0.045),
                      SizedBox(width: 4),
                      Text(
                        rating,
                        style: GoogleFonts.inter(
                          fontSize: w * 0.035,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      SizedBox(width: w * 0.04),

                      Icon(Icons.timer_outlined,
                          size: w * 0.045,
                          color: Colors.grey.shade700),
                      SizedBox(width: 4),
                      Text(
                        time,
                        style: GoogleFonts.inter(
                          fontSize: w * 0.035,
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
                      SizedBox(width: 4),
                      Text(
                        distance,
                        style: GoogleFonts.inter(
                          fontSize: w * 0.035,
                          color: Colors.grey.shade700,
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
