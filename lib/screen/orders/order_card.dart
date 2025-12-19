import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

class OrderCard extends StatelessWidget {
  final String orderId;
  final String date;
  final String productKey;
  final int qty;
  final String price;
  final String statusKey;
  final Color statusColor;
  final String image;

  const OrderCard({
    super.key,
    required this.orderId,
    required this.date,
    required this.productKey,
    required this.qty,
    required this.price,
    required this.statusKey,
    required this.statusColor,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Image.asset(
            image,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 🔥 PRODUCT NAME (LOCALIZED)
                Text(
                  loc.getByKey(productKey),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 4),

                /// 🔥 PLACED ON
                Text(
                  "${loc.placedOn}: $date",
                  style: const TextStyle(fontSize: 12),
                ),

                const SizedBox(height: 4),

                /// 🔥 QTY
                Text(
                  "${loc.qty}: $qty • $price",
                  style: const TextStyle(fontSize: 13),
                ),
              ],
            ),
          ),

          /// 🔥 STATUS
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              loc.getByKey(statusKey),
              style: TextStyle(
                color: statusColor,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
