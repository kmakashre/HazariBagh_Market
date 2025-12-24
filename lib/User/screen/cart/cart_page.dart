import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hazari_bagh_market/widgets/top_header.dart';
import '../../../l10n/app_localizations.dart';
import '../../provider/cart_provider.dart';
import '../categories/payment_method_screen.dart';

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
          if (cart.cartItems.isEmpty) {
            return Center(
              child: Text(
                loc.getByKey('cart_empty'),
                style: TextStyle(
                  fontSize: mq.width * 0.05,
                  color: colors.onBackground.withOpacity(0.6),
                ),
              ),
            );
          }

          /// 🧩 GROUP ITEMS BY STORE
          final Map<String, List<Map<String, dynamic>>> groupedItems = {};
          for (var item in cart.cartItems) {
            final store =
                item["store"] ?? loc.getByKey('unknown_store');
            groupedItems.putIfAbsent(store, () => []);
            groupedItems[store]!.add(item);
          }

          return Column(
            children: [
              const TopHeader(),

              Expanded(
                child: ListView(
                  padding: EdgeInsets.all(mq.width * 0.03),
                  children: groupedItems.entries.map((entry) {
                    return _storeCard(
                      context: context,
                      mq: mq,
                      storeName: entry.key,
                      items: entry.value,
                      cart: cart,
                      loc: loc,
                      colors: colors,
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  /// 🏪 STORE CARD
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

          Divider(height: mq.height * 0.025),

          /// 🧾 ITEMS
          ...items.map((item) {
            final index = cart.cartItems.indexOf(item);

            return Padding(
              padding: EdgeInsets.only(bottom: mq.height * 0.015),
              child: Row(
                children: [
                  /// IMAGE
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

                  /// NAME
                  Expanded(
                    child: Text(
                      item["name"],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: mq.width * 0.038,
                        fontWeight: FontWeight.w500,
                        color: colors.onSurface,
                      ),
                    ),
                  ),

                  /// QTY
                  Row(
                    children: [
                      _qtyBtn(
                        mq,
                        Icons.remove,
                            () => cart.decreaseQty(index),
                        colors,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: mq.width * 0.02),
                        child: Text(
                          "${item["qty"]}",
                          style: TextStyle(
                            fontSize: mq.width * 0.04,
                            fontWeight: FontWeight.bold,
                            color: colors.onSurface,
                          ),
                        ),
                      ),
                      _qtyBtn(
                        mq,
                        Icons.add,
                            () => cart.increaseQty(index),
                        colors,
                      ),
                    ],
                  ),

                  SizedBox(width: mq.width * 0.03),

                  /// PRICE
                  Text(
                    "₹${item["price"] * item["qty"]}",
                    style: TextStyle(
                      fontSize: mq.width * 0.038,
                      fontWeight: FontWeight.w600,
                      color: colors.onSurface,
                    ),
                  ),

                  SizedBox(width: mq.width * 0.02),

                  /// DELETE
                  GestureDetector(
                    onTap: () => cart.removeItem(index),
                    child: Icon(
                      Icons.delete,
                      color: colors.error,
                    ),
                  ),
                ],
              ),
            );
          }),

          Divider(height: mq.height * 0.03),

          /// 💰 BILL
          _billRow(
            mq,
            loc.getByKey('subtotal'),
            "₹${storeSubtotal.toStringAsFixed(0)}",
            colors,
          ),
          _billRow(
            mq,
            loc.getByKey('delivery_fee'),
            "₹40",
            colors,
          ),

          Divider(),

          _billRow(
            mq,
            loc.getByKey('payable_amount'),
            "₹${payable.toStringAsFixed(0)}",
            colors,
            isBold: true,
            valueColor: colors.primary,
          ),

          SizedBox(height: mq.height * 0.015),

          /// 💳 PAYMENT BUTTON
          SizedBox(
            width: double.infinity,
            height: mq.height * 0.055,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PaymentMethodScreen(),
                  ),
                );
              },
              child: Text(
                loc.getByKey('payment'),
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
    );
  }

  /// ➕➖ QTY BUTTON
  Widget _qtyBtn(
      Size mq,
      IconData icon,
      VoidCallback onTap,
      ColorScheme colors,
      ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(mq.width * 0.015),
        decoration: BoxDecoration(
          border: Border.all(color: colors.outline),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          size: mq.width * 0.045,
          color: colors.onSurface,
        ),
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
        Color? valueColor,
      }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: mq.height * 0.004),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: mq.width * 0.038,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
              color: colors.onSurface,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: mq.width * 0.038,
              color: valueColor ?? colors.onSurface,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
