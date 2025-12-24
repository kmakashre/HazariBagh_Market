import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../widgets/top_header.dart';
import '../../../provider/food_provider.dart';
import 'restaurant_card.dart';

class FoodHomeScreen extends StatelessWidget {
  const FoodHomeScreen({super.key});

  static const Color bannerBlue = Color(0xFF2E6DA4);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    final loc = AppLocalizations.of(context);
    final foodProvider = context.watch<FoodProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bgColor = isDark ? const Color(0xFF0F172A) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final subTextColor =
    isDark ? Colors.grey.shade300 : Colors.black54;
    final backIconColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        children: [
          /// 🔝 TOP HEADER
          const TopHeader(),
          SizedBox(height: h * 0.004),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: h * 0.015),

                  /// 🔙 BACK
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.03),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          borderRadius: BorderRadius.circular(8),
                          child: Row(
                            children: [
                              Icon(Icons.arrow_back,
                                  color: backIconColor),
                              SizedBox(width: w * 0.02),
                              Text(
                                loc.back,
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: w * 0.045,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: h * 0.008),

                  /// 🍔 FOOD DELIVERY BANNER
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(w * 0.05),
                      decoration: BoxDecoration(
                        color: bannerBlue,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            loc.getByKey('foodDelivery'),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: w * 0.055,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: h * 0.008),
                          Text(
                            loc.getByKey('foodDeliverySubtitle'),
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: w * 0.036,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: h * 0.025),

                  /// 🍽 RESTAURANTS NEAR YOU
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                    child: Text(
                      loc.getByKey('restaurantsNearYou'),
                      style: TextStyle(
                        fontSize: w * 0.05,
                        fontWeight: FontWeight.w700,
                        color: textColor,
                      ),
                    ),
                  ),

                  SizedBox(height: h * 0.015),

                  /// 🧾 RESTAURANT LIST
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                    child: foodProvider.isLoading
                        ? const Center(
                      child: CircularProgressIndicator(),
                    )
                        : ListView.builder(
                      shrinkWrap: true,
                      physics:
                      const NeverScrollableScrollPhysics(),
                      itemCount:
                      foodProvider.allRestaurants.length,
                      itemBuilder: (context, index) {
                        final restaurant =
                        foodProvider.allRestaurants[index];

                        return Padding(
                          padding:
                          EdgeInsets.only(bottom: h * 0.018),
                          child: RestaurantCard(
                            restaurant: restaurant,
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: h * 0.03),

                  /// 🎉 OFFER BANNER
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Stack(
                        children: [
                          Image.asset(
                            'assets/images/grocery.jpg',
                            height: h * 0.22,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            right: w * 0.05,
                            bottom: h * 0.04,
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Flat 50% OFF',
                                  style: TextStyle(
                                    color: Colors.yellow,
                                    fontSize: w * 0.06,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: h * 0.005),
                                Text(
                                  'On Food Orders',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: w * 0.035,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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
