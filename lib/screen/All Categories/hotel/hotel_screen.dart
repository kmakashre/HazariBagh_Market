import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../provider/hotel_provider.dart';
import '../../../widgets/top_header.dart';
import 'hotel_category_card.dart';

class HotelScreen extends StatelessWidget {
  const HotelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final hotelProvider = context.watch<HotelProvider>();
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔝 TOP HEADER
          const TopHeader(),

          SizedBox(height: w * 0.015),

          /// 🔙 BACK BUTTON
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.03),
            child: InkWell(
              onTap: () => Navigator.pop(context),
              borderRadius: BorderRadius.circular(8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.arrow_back, color: Colors.black),
                  SizedBox(width: w * 0.02),
                  Text(
                    "Back",
                    style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: w * 0.045,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: w * 0.02),

          /// 🏨 HOTEL CATEGORIES GRID
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(w * 0.04),
              child: hotelProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : GridView.builder(
                itemCount: hotelProvider.categories.length,
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: w * 0.04,
                  mainAxisSpacing: w * 0.04,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  return HotelCategoryCard(
                    category: hotelProvider.categories[index],
                    width: w,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
