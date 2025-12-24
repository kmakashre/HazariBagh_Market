import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../Model/product_model.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../widgets/top_header.dart';
import '../../../provider/hotel_provider.dart';
import '../../../provider/cart_provider.dart';

class HotelProductListScreen extends StatelessWidget {
  /// 🔑 ALWAYS ENGLISH KEY
  final String categoryTitle;

  const HotelProductListScreen({
    super.key,
    required this.categoryTitle,
  });

  @override
  Widget build(BuildContext context) {
    final hotelProvider = context.watch<HotelProvider>();
    final loc = AppLocalizations.of(context);

    final products =
    hotelProvider.getProductsByCategory(categoryTitle);

    final w = MediaQuery.of(context).size.width;

    /// 🎨 THEME
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: colors.surface,

      body: Column(
        children: [
          /// 🔝 TOP HEADER
          const TopHeader(),

          /// 🔙 BACK + TITLE
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: 8),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: colors.primary,
                  ),
                  onPressed: () => Navigator.pop(context),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                SizedBox(width: w * 0.02),

                /// 📛 CATEGORY TITLE
                Text(
                  loc.getByKey(categoryTitle),
                  style: GoogleFonts.inter(
                    color: colors.primary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          /// 🧺 PRODUCT LIST
          Expanded(
            child: products.isEmpty
                ? Center(
              child: Text(
                "${loc.getByKey('no_products')} ${loc.getByKey(categoryTitle)}",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: colors.onSurface.withOpacity(0.6),
                ),
              ),
            )
                : ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: w * 0.04),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return _buildProductCard(
                  context,
                  products[index],
                  w,
                  loc,
                  colors,
                  isDark,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// 🟢 PRODUCT CARD
  Widget _buildProductCard(
      BuildContext context,
      ProductModel product,
      double w,
      AppLocalizations loc,
      ColorScheme colors,
      bool isDark,
      ) {
    final cartProvider =
    Provider.of<CartProvider>(context, listen: false);

    final imageSize = w * 0.20;
    final padding = w * 0.03;

    return Card(
      margin: EdgeInsets.symmetric(vertical: w * 0.02),
      color: colors.surface,
      elevation: isDark ? 0 : 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isDark
            ? BorderSide(color: colors.outline.withOpacity(0.2))
            : BorderSide.none,
      ),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Row(
          children: [
            /// 🖼 IMAGE
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                product.image,
                width: imageSize,
                height: imageSize,
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(width: padding),

            /// 📝 DETAILS
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// PRODUCT NAME
                  Text(
                    loc.getByKey(product.name),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: w * 0.04,
                      fontWeight: FontWeight.w600,
                      color: colors.onSurface,
                    ),
                  ),

                  SizedBox(height: w * 0.01),

                  /// 💰 PRICE
                  Text(
                    product.price,
                    style: GoogleFonts.inter(
                      fontSize: w * 0.035,
                      color: colors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            /// 🛒 ADD TO CART
            ElevatedButton.icon(
              onPressed: () {
                cartProvider.addItem({
                  "name": product.name,
                  "price": double.tryParse(
                    product.price
                        .replaceAll(RegExp(r'[^\d.]'), ''),
                  ) ??
                      0.0,
                  "qty": 1,
                  "image": product.image,
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: colors.inverseSurface,
                    content: Text(
                      "${loc.getByKey(product.name)} ${loc.getByKey('added_to_cart')}",
                      style: GoogleFonts.inter(
                        color: colors.onInverseSurface,
                      ),
                    ),
                    duration: const Duration(milliseconds: 800),
                  ),
                );
              },
              icon: Icon(Icons.shopping_bag, size: w * 0.045),
              label: Text(
                loc.getByKey('add'),
                style: GoogleFonts.inter(
                  fontSize: w * 0.035,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primary,
                foregroundColor: colors.onPrimary,
                padding: EdgeInsets.symmetric(
                  horizontal: w * 0.025,
                  vertical: w * 0.015,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
