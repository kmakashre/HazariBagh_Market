import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../l10n/app_localizations.dart';
import '../provider/store_provider.dart';

class StoreDetailsScreen extends StatelessWidget {
  const StoreDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final storeProvider = context.watch<StoreProvider>();
    final store = storeProvider.selectedStore;

    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    /// 🎨 THEME
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    if (store == null) {
      return Scaffold(
        backgroundColor: colors.background,
        body: Center(
          child: Text(
            loc.noDataFound,
            style: GoogleFonts.inter(
              fontSize: w * 0.04,
              color: colors.onBackground,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: colors.background,

      /// 🌈 APP BAR
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          loc.getByKey(store.nameKey),
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            fontSize: w * 0.045,
          ),
        ),
        flexibleSpace: const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF3670A3), Color(0xFF4B8AC9)],
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
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
                Positioned(
                  bottom: h * 0.02,
                  left: w * 0.04,
                  child: _ratingChip(store.rating, w),
                ),
              ],
            ),

            /// 📦 CONTENT CARD
            Container(
              transform: Matrix4.translationValues(0, -h * 0.03, 0),
              padding: EdgeInsets.all(w * 0.045),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius:
                const BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 🏬 STORE NAME
                  Text(
                    loc.getByKey(store.nameKey),
                    style: GoogleFonts.inter(
                      fontSize: w * 0.055,
                      fontWeight: FontWeight.w700,
                      color: colors.onSurface,
                    ),
                  ),

                  SizedBox(height: h * 0.008),

                  /// 🗂 CATEGORY
                  _categoryChip(
                    loc.getByKey(store.categoryKey),
                    w,
                    colors,
                  ),

                  SizedBox(height: h * 0.02),

                  /// 📍 INFO ROW
                  Row(
                    children: [
                      _infoItem(
                        icon: Icons.location_on,
                        text: store.distance,
                        color: Colors.redAccent,
                        w: w,
                      ),
                      SizedBox(width: w * 0.05),
                      _infoItem(
                        icon: Icons.star,
                        text: store.rating.toString(),
                        color: Colors.orange,
                        w: w,
                      ),
                    ],
                  ),

                  SizedBox(height: h * 0.03),
                  Divider(color: colors.outline.withOpacity(0.3)),
                  SizedBox(height: h * 0.02),

                  /// 📖 ABOUT
                  Text(
                    loc.aboutStore,
                    style: GoogleFonts.inter(
                      fontSize: w * 0.045,
                      fontWeight: FontWeight.w700,
                      color: colors.onSurface,
                    ),
                  ),
                  SizedBox(height: h * 0.01),
                  Text(
                    loc.aboutStoreDesc,
                    style: GoogleFonts.inter(
                      fontSize: w * 0.038,
                      height: 1.5,
                      color: colors.onSurface.withOpacity(0.75),
                    ),
                  ),

                  SizedBox(height: h * 0.04),

                  /// 🚀 VISIT BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: h * 0.065,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        loc.visitStore,
                        style: GoogleFonts.inter(
                          fontSize: w * 0.045,
                          fontWeight: FontWeight.w600,
                          color: colors.onPrimary,
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

  /// 🔹 UI HELPERS

  Widget _ratingChip(double rating, double w) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: w * 0.025,
        vertical: w * 0.015,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.star, color: Colors.orange, size: 16),
          SizedBox(width: w * 0.01),
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

  Widget _categoryChip(String category, double w, ColorScheme colors) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: w * 0.03,
        vertical: w * 0.012,
      ),
      decoration: BoxDecoration(
        color: colors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        category,
        style: GoogleFonts.inter(
          fontSize: w * 0.032,
          color: colors.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _infoItem({
    required IconData icon,
    required String text,
    required Color color,
    required double w,
  }) {
    return Row(
      children: [
        Icon(icon, color: color, size: w * 0.045),
        SizedBox(width: w * 0.01),
        Text(
          text,
          style: GoogleFonts.inter(
            fontSize: w * 0.035,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
