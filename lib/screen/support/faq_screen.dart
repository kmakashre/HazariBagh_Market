import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../colors/AppColors.dart';

class FaqScreenUpdated extends StatelessWidget {
  FaqScreenUpdated({super.key});

  final List<Map<String, String>> faqs = [
    {
      "q": "How do I track my order?",
      "a": "You can track your order from the Orders section in your profile."
    },
    {
      "q": "What payment methods are accepted?",
      "a": "We accept UPI, Debit Card, Credit Card and Cash on Delivery."
    },
    {
      "q": "How can I cancel my order?",
      "a": "Orders can be cancelled before dispatch from the Orders page."
    },
    {
      "q": "Is there a delivery fee?",
      "a": "Delivery fee depends on distance and order value."
    },
    {
      "q": "How do I become a vendor?",
      "a": "You can register as a vendor from the Become a Vendor section."
    },
    {
      "q": "What is your refund policy?",
      "a": "Refunds are processed within 5–7 working days after approval."
    },
  ];

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.bgLight,

      body: ListView.builder(
        padding: EdgeInsets.all(w * 0.04),
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),

            /// 🔽 EXPANSION TILE
            child: ExpansionTile(
              tilePadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 6,
              ),
              childrenPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),

              title: Text(
                faqs[index]["q"]!,
                style: GoogleFonts.inter(
                  fontSize: w * 0.042,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),

              trailing: const Icon(
                Icons.keyboard_arrow_down_rounded,
              ),

              children: [
                Text(
                  faqs[index]["a"]!,
                  style: GoogleFonts.inter(
                    fontSize: w * 0.038,
                    height: 1.4,
                    color: AppColors.textGrey,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
