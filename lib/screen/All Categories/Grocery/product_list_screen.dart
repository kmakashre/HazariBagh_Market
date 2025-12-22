import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
          ///  TOP HEADER
          const TopHeader(),

          /// 🔙 BACK + TITLE
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
                  style: const TextStyle(
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
                "No products currently listed for $categoryTitle.",
                style: const TextStyle(
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

    return Card(
      margin: EdgeInsets.symmetric(vertical: w * 0.02),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                    style: TextStyle(
                      fontSize: w * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: w * 0.008),

                  /// 🏪 STORE NAME (IMPORTANT)
                  Text(
                    product.storeName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: w * 0.032,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  SizedBox(height: w * 0.01),

                  /// Price
                  Text(
                    product.price,
                    style: TextStyle(
                      fontSize: w * 0.035,
                      color: AppColors.success,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            /// 🛒 ADD TO CART (STORE INCLUDED)
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

                  /// 🔑 VERY IMPORTANT
                  "store": product.storeName,
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "${product.name} added from ${product.storeName}",
                    ),
                    duration: const Duration(milliseconds: 800),
                  ),
                );
              },
              icon: Icon(Icons.add_shopping_cart, size: w * 0.045),
              label: const Text("Add"),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: w * 0.025,
                  vertical: w * 0.015,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                textStyle: TextStyle(fontSize: w * 0.035),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
