import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import 'home/home_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final loc = AppLocalizations.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: h * 0.02),

            /// 🔍 SEARCH BAR
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: w * 0.04,
                vertical: h * 0.01,
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
                        cursorColor: const Color(0xFF3670A3),
                        decoration: InputDecoration(
                          hintText: loc.getByKey('search_hint'),
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
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const HomeScreen(),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Icon(Icons.arrow_back, size: w * 0.05),
                    SizedBox(width: w * 0.015),
                    Text(
                      loc.getByKey('back'),
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
                loc.getByKey('recent_searches'),
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
                  _recentChip(loc.getByKey('groceryStore'), w),
                  _recentChip(loc.getByKey('electronicsStore'), w),
                  _recentChip(loc.getByKey('milkStore'), w),
                  _recentChip(loc.getByKey('fashionStore'), w),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔵 RECENT SEARCH CHIP
  Widget _recentChip(String label, double w) {
    return Chip(
      label: Text(
        label,
        style: TextStyle(fontSize: w * 0.035),
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
