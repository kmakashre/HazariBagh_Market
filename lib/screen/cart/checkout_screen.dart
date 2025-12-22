import 'package:flutter/material.dart';
import '../categories/payment_method_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool homeDelivery = true;

  static const Color primaryColor = Color(0xFF3670A3);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          ///  TOP BAR
          Container(
            color: primaryColor,
            padding: EdgeInsets.symmetric(
              horizontal: w * 0.04,
              vertical: h * 0.02,
            ),
            child: SafeArea(
              bottom: false,
              child: Row(
                children: [
                  Text(
                    "Proceed To Checkout",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: w * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Icon(Icons.notifications,
                      color: Colors.white, size: w * 0.06),
                  SizedBox(width: w * 0.03),
                  Icon(Icons.person,
                      color: Colors.white, size: w * 0.06),
                ],
              ),
            ),
          ),

          /// 📜 CONTENT
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(w * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 🔙 BACK + TITLE
                  Row(
                    children: [
                      Icon(Icons.arrow_back,
                          size: w * 0.055, color: Colors.black),
                      SizedBox(width: w * 0.02),
                      Text(
                        "Delivery Details",
                        style: TextStyle(
                          fontSize: w * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: h * 0.025),

                  /// 🚚 HOME DELIVERY
                  _deliveryOption(
                    w: w,
                    h: h,
                    selected: homeDelivery,
                    icon: Icons.location_on,
                    title: "Home Delivery",
                    subtitle: "Get It Delivered To Your Doorstep",
                    onTap: () => setState(() => homeDelivery = true),
                  ),

                  SizedBox(height: h * 0.015),

                  /// 🏪 STORE PICKUP
                  _deliveryOption(
                    w: w,
                    h: h,
                    selected: !homeDelivery,
                    icon: Icons.store,
                    title: "Store Pickup",
                    subtitle: "Collect From Store - No Delivery Fee",
                    onTap: () => setState(() => homeDelivery = false),
                  ),

                  SizedBox(height: h * 0.035),

                  /// 📍 ADDRESS
                  Text(
                    "Delivery Address",
                    style: TextStyle(
                      fontSize: w * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: h * 0.012),

                  TextField(
                    maxLines: 3,
                    style: TextStyle(fontSize: w * 0.038),
                    decoration: InputDecoration(
                      hintText:
                      "Enter Your Complete Delivery Address...",
                      hintStyle:
                      TextStyle(fontSize: w * 0.035),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(w * 0.03),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  SizedBox(height: h * 0.05),

                  /// 🔘 BUTTONS
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: h * 0.065,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                              Colors.grey.shade400,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(w * 0.03),
                              ),
                            ),
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              "Back To Cart",
                              style: TextStyle(
                                fontSize: w * 0.04,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: w * 0.03),

                      Expanded(
                        child: SizedBox(
                          height: h * 0.065,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(w * 0.03),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                  const PaymentMethodScreen(),
                                ),
                              );
                            },
                            child: Text(
                              "Continue",
                              style: TextStyle(
                                fontSize: w * 0.04,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ✅ DELIVERY OPTION TILE
  Widget _deliveryOption({
    required double w,
    required double h,
    required bool selected,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(w * 0.04),
      child: Container(
        padding: EdgeInsets.all(w * 0.04),
        decoration: BoxDecoration(
          color: selected ? Colors.blue.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(w * 0.04),
          border: Border.all(
            color: selected ? Colors.blue : Colors.transparent,
            width: 1.2,
          ),
        ),
        child: Row(
          children: [
            Icon(icon,
                color: Colors.blue, size: w * 0.06),
            SizedBox(width: w * 0.03),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: w * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: h * 0.004),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: w * 0.033,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            if (selected)
              Icon(Icons.check_circle,
                  color: Colors.green, size: w * 0.06),
          ],
        ),
      ),
    );
  }
}
