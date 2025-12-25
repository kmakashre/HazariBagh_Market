import 'package:flutter/material.dart';

class VendorProductsScreen extends StatelessWidget {
  const VendorProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

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
      body: SafeArea(
        child: Padding(
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
                      padding: EdgeInsets.symmetric(
                        horizontal: w * 0.035,
                        vertical: h * 0.012,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {},
                    icon: Icon(Icons.add, size: w * 0.05),
                    label: Text(
                      "Add",
                      style: TextStyle(fontSize: w * 0.038),
                    ),
                  ),
                ],
              ),

              SizedBox(height: h * 0.02),

              /// 📦 PRODUCT LIST
              Expanded(
                child: ListView.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return _productCard(
                      w,
                      h,
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
      ),
    );
  }

  Widget _productCard(
      double w,
      double h,
      Color cardColor,
      Color textColor,
      Color subTextColor,
      Color shadowColor,
      bool isDark,
      ) {
    return Container(
      margin: EdgeInsets.only(bottom: h * 0.018),
      padding: EdgeInsets.all(w * 0.035),
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
            child: Icon(
              Icons.fastfood,
              color: Colors.blue,
              size: w * 0.09,
            ),
          ),

          SizedBox(width: w * 0.035),

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
                SizedBox(height: h * 0.005),
                Text(
                  "₹120",
                  style: TextStyle(
                    fontSize: w * 0.038,
                    fontWeight: FontWeight.w600,
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: h * 0.008),
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
