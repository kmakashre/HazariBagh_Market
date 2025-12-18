import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Model/hotel_category_model.dart';
import 'hotel_product_list_screen.dart';

class HotelCategoryCard extends StatelessWidget {
  final HotelCategoryModel category;
  final double width;

  const HotelCategoryCard({
    super.key,
    required this.category,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => HotelProductListScreen(
              categoryTitle: category.title,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            /// 🖼 IMAGE
            Expanded(
              flex: 7,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(14),
                ),
                child: Image.asset(
                  category.image,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            /// 📛 TITLE
            Expanded(
              flex: 3,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    category.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,

                    /// ✅ FONT FAMILY ADDED HERE
                    style: GoogleFonts.inter(
                      fontSize: width * 0.032,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),

                    // 👉 Try these if you want different looks:
                    // GoogleFonts.poppins(...)
                    // GoogleFonts.montserrat(...)
                    // GoogleFonts.roboto(...)
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
