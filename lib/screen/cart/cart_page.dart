import 'package:flutter/material.dart';
import 'package:hazari_bagh_market/screen/categories/payment_method_screen.dart';
import 'package:hazari_bagh_market/widgets/top_header.dart';
import 'package:provider/provider.dart';
import '../../provider/cart_provider.dart';
import '../../colors/AppColors.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          if (cart.cartItems.isEmpty) {
            return Center(
              child: Text(
                "Your cart is empty",
                style: TextStyle(
                  fontSize: mq.width * 0.05,
                  color: AppColors.textGrey,
                ),
              ),
            );
          }

          ///  GROUP ITEMS BY STORE
          final Map<String, List<Map<String, dynamic>>> groupedItems = {};
          for (var item in cart.cartItems) {
            final store = item["store"] ?? "Unknown Store";
            groupedItems.putIfAbsent(store, () => []);
            groupedItems[store]!.add(item);
          }

          return Column(
            children: [
              const TopHeader(),

              /// 🏪 STORE WISE CART
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

  /// 🏪 STORE CARD WITH IMAGE + BILLING
  Widget _storeCard({
    required BuildContext context,
    required Size mq,
    required String storeName,
    required List<Map<String, dynamic>> items,
    required CartProvider cart,
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
      decoration: _box(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🏪 STORE HEADER
          Row(
            children: [
              const Icon(Icons.store, color: AppColors.success),
              SizedBox(width: mq.width * 0.02),
              Text(
                storeName,
                style: TextStyle(
                  fontSize: mq.width * 0.045,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          Divider(height: mq.height * 0.025),

          /// 🧾 ITEMS LIST
          ...items.map((item) {
            final index = cart.cartItems.indexOf(item);

            return Padding(
              padding: EdgeInsets.only(bottom: mq.height * 0.015),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// 🖼 PRODUCT IMAGE
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

                  /// 📝 NAME
                  Expanded(
                    child: Text(
                      item["name"],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: mq.width * 0.038,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  /// ➖➕ QTY
                  Row(
                    children: [
                      _qtyBtn(
                        mq,
                        Icons.remove,
                            () => cart.decreaseQty(index),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: mq.width * 0.02),
                        child: Text(
                          "${item["qty"]}",
                          style: TextStyle(
                            fontSize: mq.width * 0.04,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      _qtyBtn(
                        mq,
                        Icons.add,
                            () => cart.increaseQty(index),
                      ),
                    ],
                  ),

                  SizedBox(width: mq.width * 0.03),

                  /// 💰 PRICE
                  Text(
                    "₹${item["price"] * item["qty"]}",
                    style: TextStyle(
                      fontSize: mq.width * 0.038,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(width: mq.width * 0.02),

                  /// 🗑 REMOVE
                  GestureDetector(
                    onTap: () => cart.removeItem(index),
                    child: const Icon(Icons.delete, color: AppColors.error),
                  ),
                ],
              ),
            );
          }),

          Divider(height: mq.height * 0.03),

          /// 💳 STORE BILLING
          _billRow(mq, "Subtotal", "₹${storeSubtotal.toStringAsFixed(0)}"),
          _billRow(mq, "Delivery Fee", "₹40"),

          Divider(),

          _billRow(
            mq,
            "Payable Amount",
            "₹${payable.toStringAsFixed(0)}",
            isBold: true,
            color: AppColors.success,
          ),

          SizedBox(height: mq.height * 0.015),

          /// ✅ STORE CHECKOUT BUTTON
          SizedBox(
            width: double.infinity,
            height: mq.height * 0.055,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {

                Navigator.push(context, MaterialPageRoute(builder: (_)=> PaymentMethodScreen()));
              },
              child: Text(
                "Payment",
                style: TextStyle(
                  fontSize: mq.width * 0.04,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ➕➖ QTY BUTTON
  Widget _qtyBtn(Size mq, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(mq.width * 0.015),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: mq.width * 0.045),
      ),
    );
  }

  /// 📊 BILL ROW
  Widget _billRow(
      Size mq,
      String title,
      String value, {
        bool isBold = false,
        Color color = AppColors.textDark,
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
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: mq.width * 0.038,
              color: color,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  /// 🎨 CARD DECORATION
  BoxDecoration _box() => BoxDecoration(
    color: AppColors.white,
    borderRadius: BorderRadius.circular(14),
    boxShadow: [
      BoxShadow(
        color: AppColors.shadow,
        blurRadius: 5,
        offset: const Offset(0, 2),
      )
    ],
  );
}
