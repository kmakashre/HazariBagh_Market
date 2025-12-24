import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../widgets/top_header.dart';

class ViewStoreScreen extends StatelessWidget {
  const ViewStoreScreen({super.key});

  static const Color primaryColor = Color(0xFF3670A3);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Column(
          children: [
            const TopHeader(),

            ///  TITLE BAR
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: w * 0.04,
                vertical: 10,
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back,
                      color: primaryColor,
                      size: w * 0.06,
                    ),
                  ),
                  SizedBox(width: w * 0.02),
                  Text(
                    "Stores",
                    style: GoogleFonts.poppins(
                      fontSize: w * 0.045,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),

            /// 🔥 GRID LIST
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.all(w * 0.04),
                itemCount: 8,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: w * 0.04,
                  crossAxisSpacing: w * 0.04,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  return storeCard(w);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🟦 STORE CARD (OVERFLOW SAFE)
  Widget storeCard(double w) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🖼 IMAGE
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(14),
            ),
            child: Image.asset(
              "assets/images/clothe.jpg",
              height: 110,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 🏪 STORE NAME
                Text(
                  "Fashion Store",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: w * 0.038,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 4),

                /// 📍 ADDRESS
                Text(
                  "Main Market, Hazaribagh",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: w * 0.032,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 6),

                /// ⭐ RATING
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.orange,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "4.5",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: w * 0.032,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
