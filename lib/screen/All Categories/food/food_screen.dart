import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hazari_bagh_market/screen/All%20Categories/food/restaurant_card.dart';
import '../../../widgets/top_header.dart';

class FoodHomeScreen extends StatelessWidget {
  const FoodHomeScreen({super.key});

  static const Color foodGreen = Color(0xFFD0B5B5);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [

          /// 🔝 FIXED HEADER
          const TopHeader(),

          /// 🔽 SCROLLABLE CONTENT
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(height: h * 0.02),

                  /// 🔙 BACK BUTTON
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: w * 0.04,
                      vertical: h * 0.01,
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () => Navigator.pop(context),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.arrow_back,
                            color: foodGreen,
                            size: w * 0.06,
                          ),
                          SizedBox(width: w * 0.02),
                          Text(
                            "Back",
                            style: GoogleFonts.inter(
                              fontSize: w * 0.045,
                              fontWeight: FontWeight.w600,
                              color: foodGreen,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: h * 0.02),

                  /// 🍔 FOOD DELIVERY BANNER
                  Padding(
                    padding: EdgeInsets.all(w * 0.02),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: w * 0.05,
                        vertical: h * 0.025,
                      ),
                      decoration: BoxDecoration(
                        color: foodGreen,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Food Delivery",
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: w * 0.055,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: h * 0.008),
                          Text(
                            "Order delicious food from top restaurants",
                            style: GoogleFonts.inter(
                              color: Colors.white70,
                              fontSize: w * 0.035,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: h * 0.025),

                  /// 🏪 SECTION TITLE
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                    child: Text(
                      "Restaurants Near You",
                      style: GoogleFonts.inter(
                        fontSize: w * 0.05,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  SizedBox(height: h * 0.015),

                  /// 🍽 RESTAURANTS LIST
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                    child: Column(
                      children: [
                        RestaurantCard(
                          size: size,
                          img: "assets/images/grocery.jpg",
                          name: "Spice Paradise",
                          type: "Indian • Mughlai • Biryani",
                          rating: "4.5",
                          time: "20–30 min",
                          distance: "0.8 km",
                        ),
                        SizedBox(height: h * 0.018),
                        RestaurantCard(
                          size: size,
                          img: "assets/images/electronics.jpg",
                          name: "Pizza Corner",
                          type: "Fast Food • Pizzas",
                          rating: "4.3",
                          time: "25–35 min",
                          distance: "1.2 km",
                        ),
                        SizedBox(height: h * 0.018),
                        RestaurantCard(
                          size: size,
                          img: "assets/images/clothe.jpg",
                          name: "The Dining Room",
                          type: "Cafe • Chinese • Continental",
                          rating: "4.6",
                          time: "18–28 min",
                          distance: "0.5 km",
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: h * 0.02),

                  /// 📸 PROMO BANNER
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(w * 0.035),
                      child: Image.asset(
                        "assets/images/grocery.jpg",
                        height: h * 0.22,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  SizedBox(height: h * 0.1),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
