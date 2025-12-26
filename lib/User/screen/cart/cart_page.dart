import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hazari_bagh_market/widgets/top_header.dart';
import '../../../l10n/app_localizations.dart';
import '../../provider/cart_provider.dart';
import '../categories/payment_method_screen.dart';
import '../home/home_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      backgroundColor: colors.background,
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          return Column(
            children: [
              const TopHeader(),

              /// 🛒 EMPTY CART UI
              if (cart.cartItems.isEmpty)
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: mq.width * 0.08),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_cart_outlined,
                            size: mq.width * 0.25,
                            color:
                            colors.onBackground.withOpacity(0.4),
                          ),
                          SizedBox(height: mq.height * 0.02),
                          Text(
                            loc.getByKey('cart_empty'),
                            style: TextStyle(
                              fontSize: mq.width * 0.05,
                              fontWeight: FontWeight.bold,
                              color: colors.onBackground,
                            ),
                          ),
                          SizedBox(height: mq.height * 0.01),
                          Text(
                            loc.getByKey(
                                'add_items_to_cart'),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: mq.width * 0.038,
                              color: colors.onBackground
                                  .withOpacity(0.6),
                            ),
                          ),
                          SizedBox(height: mq.height * 0.03),

                          /// 🏪 GO SHOPPING
                          SizedBox(
                            width: mq.width * 0.65,
                            height: mq.height * 0.055,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: colors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                    const HomeScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                loc.getByKey('continue_shopping'),
                                style: TextStyle(
                                  fontSize: mq.width * 0.04,
                                  fontWeight: FontWeight.w600,
                                  color: colors.onPrimary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )

              /// 🧾 CART ITEMS
              else
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.all(mq.width * 0.03),
                    children: _buildStoreCards(
                      context,
                      mq,
                      cart,
                      loc,
                      colors,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  /// 🧩 STORE GROUP
  List<Widget> _buildStoreCards(
      BuildContext context,
      Size mq,
      CartProvider cart,
      AppLocalizations loc,
      ColorScheme colors,
      ) {
    final Map<String, List<Map<String, dynamic>>> groupedItems = {};

    for (var item in cart.cartItems) {
      final store =
          item["store"] ?? loc.getByKey('unknown_store');
      groupedItems.putIfAbsent(store, () => []);
      groupedItems[store]!.add(item);
    }

    return groupedItems.entries.map((entry) {
      return _storeCard(
        context: context,
        mq: mq,
        storeName: entry.key,
        items: entry.value,
        cart: cart,
        loc: loc,
        colors: colors,
      );
    }).toList();
  }

  /// 🏪 STORE CARD (same as your existing)
  Widget _storeCard({
    required BuildContext context,
    required Size mq,
    required String storeName,
    required List<Map<String, dynamic>> items,
    required CartProvider cart,
    required AppLocalizations loc,
    required ColorScheme colors,
  }) {
    double storeSubtotal = 0;
    for (var i in items) {
      storeSubtotal += i["price"] * i["qty"];
    }

    const double deliveryFee = 40;
    final double payable = storeSubtotal + deliveryFee;

    return Container(
      margin: EdgeInsets.only(bottom: mq.height * 0.02),
      padding: EdgeInsets.all(mq.width * 0.035),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🏪 STORE HEADER
          Row(
            children: [
              Icon(Icons.store, color: colors.primary),
              SizedBox(width: mq.width * 0.02),
              Expanded(
                child: Text(
                  storeName,
                  style: TextStyle(
                    fontSize: mq.width * 0.045,
                    fontWeight: FontWeight.bold,
                    color: colors.onSurface,
                  ),
                ),
              ),
            ],
          ),

          const Divider(),

          /// ITEMS (unchanged)
          ...items.map((item) {
            final index = cart.cartItems.indexOf(item);
            return Padding(
              padding:
              EdgeInsets.only(bottom: mq.height * 0.015),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      item["image"],
                      width: mq.width * 0.14,
                      height: mq.width * 0.14,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: mq.width * 0.03),
                  Expanded(
                    child: Text(
                      item["name"],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: mq.width * 0.038,
                        color: colors.onSurface,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () =>
                        cart.removeItem(index),
                    icon: Icon(Icons.delete,
                        color: colors.error),
                  ),
                ],
              ),
            );
          }),

          const Divider(),

          _billRow(mq, loc.getByKey('payable_amount'),
              "₹${payable.toStringAsFixed(0)}", colors,
              isBold: true),

          SizedBox(height: mq.height * 0.015),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                    const PaymentMethodScreen(),
                  ),
                );
              },
              child: Text(loc.getByKey('payment')),
            ),
          ),
        ],
      ),
    );
  }

  /// 🧾 BILL ROW
  Widget _billRow(
      Size mq,
      String title,
      String value,
      ColorScheme colors, {
        bool isBold = false,
      }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight:
            isBold ? FontWeight.bold : FontWeight.normal,
            color: colors.onSurface,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight:
            isBold ? FontWeight.bold : FontWeight.normal,
            color: colors.primary,
          ),
        ),
      ],
    );
  }
}
