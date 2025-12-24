import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hazari_bagh_market/User/screen/categories/payment_method_screen.dart';

import '../../../widgets/top_header.dart';


class ProceedToCheckoutScreen extends StatefulWidget {
  const ProceedToCheckoutScreen({super.key});

  @override
  State<ProceedToCheckoutScreen> createState() =>
      _ProceedToCheckoutScreenState();
}

class _ProceedToCheckoutScreenState extends State<ProceedToCheckoutScreen> {
  bool isHomeDelivery = true;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const TopHeader(),

            SizedBox(height: mq.height * 0.005),

            // 🔙 BACK + TITLE
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: mq.width * 0.04,
                vertical: mq.height * 0.01,
              ),
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_back,
                      color: const Color(0xFF3670A3),
                      size: mq.width * 0.06,
                    ),
                    SizedBox(width: mq.width * 0.02),
                    Text(
                      "Delivery Details",
                      style: GoogleFonts.inter(
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

            // 🏠 HOME DELIVERY
            Padding(
              padding: EdgeInsets.all(mq.width * 0.02),
              child: GestureDetector(
                onTap: () => setState(() => isHomeDelivery = true),
                child: deliveryOption(
                  mq: mq,
                  title: "Home Delivery",
                  subtitle: "Get it Delivered To Your Doorstep",
                  isSelected: isHomeDelivery,
                ),
              ),
            ),

            // 🏪 STORE PICKUP
            Padding(
              padding: EdgeInsets.all(mq.width * 0.02),
              child: GestureDetector(
                onTap: () => setState(() => isHomeDelivery = false),
                child: deliveryOption(
                  mq: mq,
                  title: "Store Pickup",
                  subtitle: "Collect From Store - No Delivery Fee",
                  isSelected: !isHomeDelivery,
                ),
              ),
            ),

            SizedBox(height: mq.height * 0.02),

            // 📍 DELIVERY ADDRESS
            Text(
              "Delivery Address",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.bold,
                fontSize: mq.width * 0.045,
                color: const Color(0xFF3670A3),
              ),
            ),

            SizedBox(height: mq.height * 0.01),

            Padding(
              padding: EdgeInsets.all(mq.width * 0.03),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: mq.width * 0.03,
                  vertical: mq.height * 0.01,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(mq.width * 0.02),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: TextField(
                  maxLines: 3,
                  style: GoogleFonts.inter(
                    fontSize: mq.width * 0.04,
                  ),
                  decoration: InputDecoration(
                    hintText: "Enter Your Complete Delivery Address...",
                    hintStyle: GoogleFonts.inter(
                      fontSize: mq.width * 0.038,
                      color: Colors.grey,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),

            SizedBox(height: mq.height * 0.02),

            // 🔘 BUTTONS
            Padding(
              padding: EdgeInsets.symmetric(horizontal: mq.width * 0.04),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: mq.height * 0.055,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          "Back To Cart",
                          style: GoogleFonts.inter(
                            fontSize: mq.width * 0.04,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
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
                          backgroundColor: const Color(0xFF3670A3),
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
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: mq.width * 0.04,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: mq.height * 0.03),
          ],
        ),
      ),
    );
  }

  // 🔶 DELIVERY OPTION TILE
  Widget deliveryOption({
    required Size mq,
    required String title,
    required String subtitle,
    required bool isSelected,
  }) {
    return Container(
      padding: EdgeInsets.all(mq.width * 0.03),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: isSelected ? Colors.green : Colors.grey.shade300,
          width: mq.width * 0.003,
        ),
        borderRadius: BorderRadius.circular(mq.width * 0.03),
      ),
      child: Row(
        children: [
          Icon(
            isSelected
                ? Icons.check_circle
                : Icons.radio_button_unchecked,
            color: isSelected ? Colors.green : Colors.grey,
            size: mq.width * 0.065,
          ),
          SizedBox(width: mq.width * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: mq.width * 0.04,
                  ),
                ),
                SizedBox(height: mq.height * 0.005),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: mq.width * 0.032,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
