import 'package:flutter/material.dart';

class VendorProductsScreen extends StatelessWidget {
  const VendorProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final bgColor =
    isDark ? const Color(0xFF0F172A) : const Color(0xFFF6F8FC);
    final cardColor =
    isDark ? const Color(0xFF1E293B) : Colors.white;
    final textColor =
    isDark ? Colors.white : const Color(0xFF1F2937);
    final subTextColor =
    isDark ? Colors.grey.shade400 : Colors.grey.shade600;
    final shadowColor =
    isDark ? Colors.black.withOpacity(0.35) : Colors.black.withOpacity(0.08);

    return Scaffold(
      backgroundColor: bgColor,
      body: Padding(
        padding: EdgeInsets.all(w * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🛍 TITLE + ADD BUTTON
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Products",
                  style: TextStyle(
                    fontSize: w * 0.055,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  label: const Text("Add"),
                ),
              ],
            ),

            const SizedBox(height: 16),

            /// 📦 PRODUCT LIST
            Expanded(
              child: ListView.builder(
                itemCount: 6,
                itemBuilder: (context, index) {
                  return _productCard(
                    w,
                    cardColor,
                    textColor,
                    subTextColor,
                    shadowColor,
                    isDark,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _productCard(
      double w,
      Color cardColor,
      Color textColor,
      Color subTextColor,
      Color shadowColor,
      bool isDark,
      ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          /// 🖼 PRODUCT IMAGE
          Container(
            width: w * 0.18,
            height: w * 0.18,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(isDark ? 0.25 : 0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.fastfood,
              color: Colors.blue,
              size: 36,
            ),
          ),

          const SizedBox(width: 14),

          /// 📄 PRODUCT INFO
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Veg Burger",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: w * 0.04,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "₹120",
                  style: TextStyle(
                    fontSize: w * 0.038,
                    fontWeight: FontWeight.w600,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Stock: 24",
                  style: TextStyle(
                    color: subTextColor,
                    fontSize: w * 0.032,
                  ),
                ),
              ],
            ),
          ),

          /// ⚙ ACTIONS
          Column(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.edit, color: textColor),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.delete, color: Colors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
