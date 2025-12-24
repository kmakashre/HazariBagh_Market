import 'package:flutter/material.dart';
import 'package:hazari_bagh_market/User/screen/categories/placed_order_screen.dart';
import 'package:provider/provider.dart';
import '../../../l10n/app_localizations.dart';
import '../../../widgets/top_header.dart';
import '../../provider/cart_provider.dart';
import '../../provider/payment_provider.dart';


class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final cart = context.watch<CartProvider>();
    final payment = context.watch<PaymentProvider>();
    final loc = AppLocalizations.of(context);

    final subtotal = cart.subtotal;
    final deliveryFee = cart.deliveryFee;
    final totalAmount = subtotal + deliveryFee;

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
                  /// 🔙 BACK
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: mq.width * 0.04,
                        vertical: mq.height * 0.01),
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Row(
                        children: [
                          Icon(Icons.arrow_back,
                              color: const Color(0xFF3670A3),
                              size: mq.width * 0.06),
                          SizedBox(width: mq.width * 0.02),
                          Text(
                            loc.getByKey('back'),
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
                          title: loc.getByKey('cod'),
                          subtitle: loc.getByKey('cod_sub'),
                          icon: Icons.payments,
                          isSelected: payment.selectedPayment == 0,
                          onTap: () => payment.selectPayment(0),
                        ),
                        SizedBox(height: mq.height * 0.015),
                        paymentTile(
                          mq: mq,
                          title: loc.getByKey('upi'),
                          subtitle: loc.getByKey('upi_sub'),
                          icon: Icons.qr_code,
                          isSelected: payment.selectedPayment == 1,
                          onTap: () => payment.selectPayment(1),
                        ),
                        SizedBox(height: mq.height * 0.015),
                        paymentTile(
                          mq: mq,
                          title: loc.getByKey('card'),
                          subtitle: loc.getByKey('card_sub'),
                          icon: Icons.credit_card,
                          isSelected: payment.selectedPayment == 2,
                          onTap: () => payment.selectPayment(2),
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
                      ),
                      child: Column(
                        children: [
                          summaryRow(
                            mq: mq,
                            title:
                            "${loc.getByKey('subtotal')} (${cart.cartCount} ${loc.getByKey('items')})",
                            value: "₹${subtotal.toStringAsFixed(0)}",
                          ),
                          summaryRow(
                            mq: mq,
                            title: loc.getByKey('delivery_fee'),
                            value: "₹${deliveryFee.toStringAsFixed(0)}",
                          ),
                          const Divider(),
                          summaryRow(
                            mq: mq,
                            title: loc.getByKey('total'),
                            value: "₹${totalAmount.toStringAsFixed(0)}",
                            isBold: true,
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: mq.height * 0.03),

                  /// 🔘 PLACE ORDER
                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: mq.width * 0.03),
                    child: SizedBox(
                      width: double.infinity,
                      height: mq.height * 0.055,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3670A3),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PlacedOrderScreen(
                                productName: cart.cartItems.isNotEmpty
                                    ? cart.cartItems.first["name"] ??
                                    loc.getByKey('product')
                                    : loc.getByKey('product'),
                                totalAmount: totalAmount,
                                paymentMethod:
                                loc.getByKey(payment.getPaymentKey()),
                                address: cart.selectedAddress ??
                                    loc.getByKey('no_address'),
                              ),
                            ),
                          );
                        },
                        child: Text(
                          loc.getByKey('place_order'),
                          style: TextStyle(
                              fontSize: mq.width * 0.04,
                              color: Colors.white),
                        ),
                      ),
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
      child: Container(
        padding: EdgeInsets.all(mq.width * 0.03),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(mq.width * 0.03),
          border: Border.all(
              color: isSelected ? Colors.green : Colors.grey.shade300),
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
                  color: Colors.green, size: mq.width * 0.06),
          ],
        ),
      ),
    );
  }

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
