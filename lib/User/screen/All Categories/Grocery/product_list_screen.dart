import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../Model/product_model.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../widgets/top_header.dart';
import '../../../provider/grocery_provider.dart';
import '../../../provider/cart_provider.dart';

class ProductListScreen extends StatelessWidget {
  /// 🔑 ALWAYS ENGLISH KEY (used for filtering)
  final String categoryKey;

  const ProductListScreen({
    super.key,
    required this.categoryKey,
  });

  @override
  Widget build(BuildContext context) {
    final groceryProvider = context.watch<GroceryProvider>();
    final products =
    groceryProvider.getProductsByCategory(categoryKey);

    final loc = AppLocalizations.of(context);
    final w = MediaQuery.of(context).size.width;

    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      backgroundColor: colors.surface,
      body: Column(
        children: [
          /// 🔝 TOP HEADER
          const TopHeader(),

          /// 🔙 BACK + LOCALIZED TITLE
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
                  loc.getByKey(categoryKey.toLowerCase()),
                  style: TextStyle(
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
                "${loc.getByKey('no_products')} "
                    "${loc.getByKey(categoryKey.toLowerCase())}",
                textAlign: TextAlign.center,
                style: TextStyle(
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// 🟢 PRODUCT CARD (Theme Aware)
  Widget _buildProductCard(
      BuildContext context,
      ProductModel product,
      double w,
      ) {
    final cartProvider =
    Provider.of<CartProvider>(context, listen: false);
    final loc = AppLocalizations.of(context);

    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final imageSize = w * 0.20;
    final padding = w * 0.03;

    return Card(
      margin: EdgeInsets.symmetric(vertical: w * 0.02),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: colors.surface,
      elevation: theme.brightness == Brightness.dark ? 1 : 2,
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
                  Text(
                    loc.getByKey(product.name),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: w * 0.04,
                      fontWeight: FontWeight.bold,
                      color: colors.onSurface,
                    ),
                  ),
                  SizedBox(height: w * 0.008),
                  Text(
                    product.storeName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: w * 0.032,
                      color: colors.onSurface.withOpacity(0.6),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: w * 0.01),
                  Text(
                    product.price,
                    style: TextStyle(
                      fontSize: w * 0.035,
                      color: colors.primary,
                      fontWeight: FontWeight.w600,
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
                  "store": product.storeName,
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: colors.surface,
                    content: Text(
                      "${product.name} ${loc.getByKey('added_from')} ${product.storeName}",
                      style: TextStyle(color: colors.onSurface),
                    ),
                    duration: const Duration(milliseconds: 900),
                  ),
                );
              },
              icon: Icon(
                Icons.add_shopping_cart,
                size: w * 0.045,
                color: colors.onPrimary,
              ),
              label: Text(loc.getByKey('add')),
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
                textStyle: TextStyle(fontSize: w * 0.035),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
