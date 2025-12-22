import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Model/product_model.dart';
import '../../../colors/AppColors.dart';
import '../../../provider/hotel_provider.dart';
import '../../../provider/cart_provider.dart';
import '../../../widgets/top_header.dart';

class HotelProductListScreen extends StatelessWidget {
  final String categoryTitle;

  const HotelProductListScreen({
    super.key,
    required this.categoryTitle,
  });

  @override
  Widget build(BuildContext context) {
    final hotelProvider = context.watch<HotelProvider>();
    final List<ProductModel> products =
    hotelProvider.getProductsByCategory(categoryTitle);

    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          /// 🔝 TOP HEADER
          const TopHeader(),

          ///  BACK BUTTON + TITLE
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: 8),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: AppColors.success),
                  onPressed: () => Navigator.pop(context),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                SizedBox(width: w * 0.02),
                Text(
                  categoryTitle,
                  style: GoogleFonts.inter(
                    color: AppColors.success,
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
                "No listings currently available for $categoryTitle.",
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: Colors.grey,
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
      BuildContext context, ProductModel product, double w) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    final imageSize = w * 0.20;
    final padding = w * 0.03;

    return Card(
      margin: EdgeInsets.symmetric(vertical: w * 0.02),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
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
                  /// Product Name
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: w * 0.04,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),

                  SizedBox(height: w * 0.01),

                  /// Price
                  Text(
                    product.price,
                    style: GoogleFonts.inter(
                      fontSize: w * 0.035,
                      color: AppColors.success,
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
                    product.price.replaceAll(RegExp(r'[^\d.]'), ''),
                  ) ??
                      0.0,
                  "qty": 1,
                  "image": product.image,
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "${product.name} added to cart!",
                      style: GoogleFonts.inter(),
                    ),
                    duration: const Duration(milliseconds: 800),
                  ),
                );
              },
              icon: Icon(Icons.shopping_bag, size: w * 0.045),
              label: Text(
                "Add",
                style: GoogleFonts.inter(
                  fontSize: w * 0.035,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
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
