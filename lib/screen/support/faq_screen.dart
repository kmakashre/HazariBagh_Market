import 'package:flutter/material.dart';
import '../../colors/AppColors.dart';
import '../../l10n/app_localizations.dart';

class FaqScreenUpdated extends StatelessWidget {
  FaqScreenUpdated({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final w = MediaQuery.of(context).size.width;

    final List<Map<String, String>> faqs = [
      {
        "q": loc.faqTrackOrderQ,
        "a": loc.faqTrackOrderA,
      },
      {
        "q": loc.faqPaymentQ,
        "a": loc.faqPaymentA,
      },
      {
        "q": loc.faqCancelQ,
        "a": loc.faqCancelA,
      },
      {
        "q": loc.faqDeliveryFeeQ,
        "a": loc.faqDeliveryFeeA,
      },
      {
        "q": loc.faqVendorQ,
        "a": loc.faqVendorA,
      },
      {
        "q": loc.faqRefundQ,
        "a": loc.faqRefundA,
      },
    ];

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
            child: ExpansionTile(
              tilePadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              childrenPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              title: Text(
                faqs[index]["q"]!,
                style: TextStyle(
                  fontSize: w * 0.042,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
              trailing:
              const Icon(Icons.keyboard_arrow_down_rounded),
              children: [
                Text(
                  faqs[index]["a"]!,
                  style: TextStyle(
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
