import 'package:flutter/material.dart';
import 'package:hazari_bagh_market/screen/home/home_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: h * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: h * 0.02),

              /// 🔍 SEARCH BAR
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: w * 0.04,
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: w * 0.04,
                    vertical: h * 0.015,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(w * 0.06),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search_rounded,
                        color: Colors.grey.shade600,
                        size: w * 0.065,
                      ),

                      SizedBox(width: w * 0.03),

                      /// 🔤 SEARCH INPUT
                      Expanded(
                        child: TextField(
                          autofocus: true,
                          cursorColor: const Color(0xFF3670A3),
                          decoration: InputDecoration(
                            hintText: "Search stores, products...",
                            hintStyle: TextStyle(
                              fontSize: w * 0.04,
                              color: Colors.grey,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),

                      Icon(
                        Icons.mic_none_rounded,
                        color: Colors.grey.shade600,
                        size: w * 0.055,
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: h * 0.025),

              /// 🔙 BACK BUTTON
              Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                child: InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const HomeScreen(),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.arrow_back, size: w * 0.05),
                      SizedBox(width: w * 0.015),
                      Text(
                        "Back",
                        style: TextStyle(
                          fontSize: w * 0.04,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: h * 0.03),

              /// 🕘 RECENT SEARCHES
              Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                child: Text(
                  "Recent Searches",
                  style: TextStyle(
                    fontSize: w * 0.045,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              SizedBox(height: h * 0.015),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                child: Wrap(
                  spacing: w * 0.025,
                  runSpacing: h * 0.015,
                  children: [
                    _recentChip("Grocery", w),
                    _recentChip("Mobile Shop", w),
                    _recentChip("Milk Store", w),
                    _recentChip("Fashion Store", w),
                    _recentChip("Electronics", w),
                    _recentChip("Restaurant", w),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔵 RECENT SEARCH CHIP
  Widget _recentChip(String label, double w) {
    return Chip(
      label: Text(
        label,
        style: TextStyle(
          fontSize: w * 0.035,
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 2,
      padding: EdgeInsets.symmetric(
        horizontal: w * 0.03,
        vertical: w * 0.012,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(w * 0.04),
      ),
    );
  }
}
