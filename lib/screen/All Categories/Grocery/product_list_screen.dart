import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Model/product_model.dart';
import '../../../colors/AppColors.dart';
import '../../../provider/grocery_provider.dart';
import '../../../provider/cart_provider.dart';
import '../../../widgets/top_header.dart';

class ProductListScreen extends StatelessWidget {
  final String categoryTitle;

  const ProductListScreen({
    super.key,
    required this.categoryTitle,
  });

  @override
  Widget build(BuildContext context) {
    final groceryProvider = context.watch<GroceryProvider>();
    final List<ProductModel> products =
    groceryProvider.getProductsByCategory(categoryTitle);

    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [

          /// 🔝 TOP HEADER
          const TopHeader(),

          /// 🔙 BACK + TITLE
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: 10),
            child: Row(
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  borderRadius: BorderRadius.circular(8),
                  child: const Icon(
                    Icons.arrow_back,
                    color: AppColors.success,
                  ),
                ),
                SizedBox(width: w * 0.02),
                Expanded(
                  child: Text(
                    categoryTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      color: AppColors.success,
                      fontSize: w * 0.045,
                      fontWeight: FontWeight.w700,
                    ),
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
                "No products available for $categoryTitle",
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
      BuildContext context,
      ProductModel product,
      double w,
      ) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    final imageSize = w * 0.20;
    final padding = w * 0.03;

    return Container(
      margin: EdgeInsets.symmetric(vertical: w * 0.02),
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          )
        ],
      ),
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
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: w * 0.042,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                SizedBox(height: w * 0.008),

                /// 🏪 STORE NAME
                Text(
                  product.storeName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: w * 0.032,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                SizedBox(height: w * 0.01),

                /// 💰 PRICE
                Text(
                  product.price,
                  style: GoogleFonts.inter(
                    fontSize: w * 0.038,
                    color: AppColors.success,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          /// 🛒 ADD TO CART
          ElevatedButton(
            onPressed: () {
              cartProvider.addItem({
                "name": product.name,
                "price": double.tryParse(
                  product.price.replaceAll(RegExp(r'[^\d.]'), ''),
                ) ??
                    0.0,
                "qty": 1,
                "image": product.image,

                /// 🔑 STORE-WISE CART
                "store": product.storeName,
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "${product.name} added from ${product.storeName}",
                  ),
                  duration: const Duration(milliseconds: 900),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: w * 0.03,
                vertical: w * 0.018,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              textStyle: GoogleFonts.inter(
                fontSize: w * 0.035,
                fontWeight: FontWeight.w600,
              ),
            ),
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }
}
