import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hazari_bagh_market/screen/categories/placed_order_screen.dart';
import '../../provider/cart_provider.dart';
import '../../widgets/top_header.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  int selectedPayment = 0; // 0 = COD, 1 = UPI, 2 = CARD

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final cart = Provider.of<CartProvider>(context);

    final double subtotal = cart.subtotal;
    final double deliveryFee = cart.deliveryFee;
    final double totalAmount = subtotal + deliveryFee;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          const TopHeader(),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: mq.height * 0.03),
              child: Column(
                children: [
                  ///  BACK + TITLE
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: mq.width * 0.04,
                      vertical: mq.height * 0.01,
                    ),
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Row(
                        children: [
                          Icon(Icons.arrow_back,
                              color: const Color(0xFF3670A3),
                              size: mq.width * 0.06),
                          SizedBox(width: mq.width * 0.02),
                          Text(
                            "Payment Method",
                            style: TextStyle(
                              fontSize: mq.width * 0.045,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF3670A3),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: mq.height * 0.02),

                  /// 💰 PAYMENT OPTIONS
                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: mq.width * 0.03),
                    child: Column(
                      children: [
                        paymentTile(
                          mq: mq,
                          title: "Cash On Delivery",
                          subtitle: "Pay When You Receive",
                          icon: Icons.payments,
                          isSelected: selectedPayment == 0,
                          onTap: () => setState(() => selectedPayment = 0),
                        ),
                        SizedBox(height: mq.height * 0.015),
                        paymentTile(
                          mq: mq,
                          title: "UPI Payment",
                          subtitle:
                          "Google Pay, PhonePe, Paytm",
                          icon: Icons.qr_code,
                          isSelected: selectedPayment == 1,
                          onTap: () => setState(() => selectedPayment = 1),
                        ),
                        SizedBox(height: mq.height * 0.015),
                        paymentTile(
                          mq: mq,
                          title: "Debit / Credit Card",
                          subtitle: "Visa, Mastercard, Rupay",
                          icon: Icons.credit_card,
                          isSelected: selectedPayment == 2,
                          onTap: () => setState(() => selectedPayment = 2),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: mq.height * 0.03),

                  /// 🧾 ORDER SUMMARY
                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: mq.width * 0.03),
                    child: Container(
                      padding: EdgeInsets.all(mq.width * 0.03),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.circular(mq.width * 0.03),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(0, 2)),
                        ],
                      ),
                      child: Column(
                        children: [
                          summaryRow(
                            mq: mq,
                            title:
                            "Subtotal (${cart.cartCount} Items)",
                            value: "₹${subtotal.toStringAsFixed(0)}",
                          ),
                          summaryRow(
                            mq: mq,
                            title: "Delivery Fees",
                            value:
                            "₹${deliveryFee.toStringAsFixed(0)}",
                          ),
                          const Divider(),
                          summaryRow(
                            mq: mq,
                            title: "Total",
                            value:
                            "₹${totalAmount.toStringAsFixed(0)}",
                            isBold: true,
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: mq.height * 0.03),

                  /// 🔘 BUTTONS
                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: mq.width * 0.03),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: mq.height * 0.055,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                Colors.grey.shade300,
                              ),
                              onPressed: () =>
                                  Navigator.pop(context),
                              child: Text(
                                "Back",
                                style: TextStyle(
                                  fontSize: mq.width * 0.04,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: mq.width * 0.03),
                        Expanded(
                          child: SizedBox(
                            height: mq.height * 0.055,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                const Color(0xFF3670A3),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        PlacedOrderScreen(
                                          productName:
                                          cart.cartItems.isNotEmpty
                                              ? cart.cartItems.first[
                                          "name"] ??
                                              "Product"
                                              : "Product",
                                          totalAmount: totalAmount,
                                          paymentMethod: selectedPayment ==
                                              0
                                              ? "Cash On Delivery"
                                              : selectedPayment == 1
                                              ? "UPI Payment"
                                              : "Card Payment",
                                          address:
                                          cart.selectedAddress ??
                                              "No Address Found",
                                        ),
                                  ),
                                );
                              },
                              child: Text(
                                "Place Order",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: mq.width * 0.04,
                                ),
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
          ),
        ],
      ),
    );
  }

  /// 💳 PAYMENT TILE
  Widget paymentTile({
    required Size mq,
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(mq.width * 0.03),
      child: Container(
        padding: EdgeInsets.all(mq.width * 0.03),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: isSelected ? Colors.green : Colors.grey.shade300),
          borderRadius: BorderRadius.circular(mq.width * 0.03),
        ),
        child: Row(
          children: [
            Icon(icon, size: mq.width * 0.065),
            SizedBox(width: mq.width * 0.03),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(
                          fontSize: mq.width * 0.04,
                          fontWeight: FontWeight.bold)),
                  Text(subtitle,
                      style: TextStyle(
                          fontSize: mq.width * 0.032,
                          color: Colors.black54)),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle,
                  color: Colors.green,
                  size: mq.width * 0.06),
          ],
        ),
      ),
    );
  }

  /// 📊 SUMMARY ROW
  Widget summaryRow({
    required Size mq,
    required String title,
    required String value,
    bool isBold = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: mq.height * 0.006),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(
                  fontSize: mq.width * 0.038,
                  fontWeight:
                  isBold ? FontWeight.bold : FontWeight.w500)),
          Text(value,
              style: TextStyle(
                  fontSize: mq.width * 0.04,
                  fontWeight:
                  isBold ? FontWeight.bold : FontWeight.w600,
                  color: isBold ? Colors.green : Colors.black)),
        ],
      ),
    );
  }
}
