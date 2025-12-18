import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../provider/store_provider.dart';

class StoreDetailsScreen extends StatelessWidget {
  const StoreDetailsScreen({super.key});

  static const Color primaryColor = Color(0xFF3670A3);

  @override
  Widget build(BuildContext context) {
    final storeProvider = context.watch<StoreProvider>();
    final store = storeProvider.selectedStore;

    /// 🔴 SAFETY CHECK
    if (store == null) {
      return const Scaffold(
        body: Center(
          child: Text(
            "No Store Selected",
            style: TextStyle(fontSize: 16),
          ),
        ),
      );
    }

    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      /// 🔵 APP BAR
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          store.name,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
          ),
        ),
        flexibleSpace: const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF3670A3),
                Color(0xFF4B8AC9),
              ],
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// 🖼 STORE IMAGE
            Stack(
              children: [
                Image.asset(
                  store.image,
                  height: h * 0.30,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),

                /// ⭐ RATING CHIP
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: _ratingChip(store.rating),
                ),
              ],
            ),

            /// 📦 CONTENT CARD
            Container(
              transform: Matrix4.translationValues(0, -20, 0),
              padding: EdgeInsets.all(w * 0.05),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(26),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// 🏪 STORE NAME
                  Text(
                    store.name,
                    style: GoogleFonts.inter(
                      fontSize: w * 0.055,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 8),

                  /// 🏷 CATEGORY
                  _categoryChip(store.category),

                  const SizedBox(height: 18),

                  /// 📍 INFO ROW
                  Row(
                    children: [
                      _infoItem(
                        icon: Icons.location_on,
                        text: store.distance,
                        color: Colors.red,
                      ),
                      const SizedBox(width: 24),
                      _infoItem(
                        icon: Icons.star,
                        text: store.rating.toString(),
                        color: Colors.orange,
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),
                  Divider(color: Colors.grey.shade300),
                  const SizedBox(height: 18),

                  /// 📄 ABOUT
                  Text(
                    "About Store",
                    style: GoogleFonts.inter(
                      fontSize: w * 0.045,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "This store provides quality products at affordable prices. "
                        "Customer satisfaction and fast service are our top priorities.",
                    style: GoogleFonts.inter(
                      fontSize: w * 0.038,
                      height: 1.6,
                      color: Colors.grey.shade700,
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// 🚀 VISIT STORE BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: h * 0.06,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () {
                        // TODO: Navigate to store products page
                      },
                      child: Text(
                        "Visit Store",
                        style: GoogleFonts.inter(
                          fontSize: w * 0.042,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ⭐ RATING CHIP
  Widget _ratingChip(double rating) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.65),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const Icon(Icons.star, color: Colors.orange, size: 16),
          const SizedBox(width: 4),
          Text(
            rating.toString(),
            style: GoogleFonts.inter(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  /// 🏷 CATEGORY CHIP
  Widget _categoryChip(String category) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.12),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Text(
        category,
        style: GoogleFonts.inter(
          fontSize: 13,
          color: primaryColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  /// 📍 INFO ITEM
  Widget _infoItem({
    required IconData icon,
    required String text,
    required Color color,
  }) {
    return Row(
      children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(width: 6),
        Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
