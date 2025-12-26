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

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final bgColor = isDark ? const Color(0xFF121212) : Colors.grey.shade100;
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = theme.textTheme.bodyLarge!.color!;
    final hintColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;

    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
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
                  color: cardColor,
                  borderRadius: BorderRadius.circular(w * 0.06),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(isDark ? 0.3 : 0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.search_rounded,
                      color: hintColor,
                      size: w * 0.065,
                    ),
                    SizedBox(width: w * 0.03),

                    /// 🔤 SEARCH INPUT
                    Expanded(
                      child: TextField(
                        cursorColor: theme.primaryColor,
                        style: TextStyle(color: textColor),
                        decoration: InputDecoration(
                          hintText: loc.getByKey('search_hint'),
                          hintStyle: TextStyle(
                            fontSize: w * 0.04,
                            color: hintColor,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),

                    Icon(
                      Icons.mic_none_rounded,
                      color: hintColor,
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
                onTap: () => Navigator.pop(context),
                child: Row(
                  children: [
                    Icon(Icons.arrow_back, size: w * 0.05, color: textColor),
                    SizedBox(width: w * 0.015),
                    Text(
                      loc.getByKey('back'),
                      style: TextStyle(
                        fontSize: w * 0.04,
                        fontWeight: FontWeight.w600,
                        color: textColor,
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
                  color: textColor,
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
                  _recentChip(loc.getByKey('groceryStore'), w, cardColor, textColor),
                  _recentChip(loc.getByKey('electronicsStore'), w, cardColor, textColor),
                  _recentChip(loc.getByKey('milkStore'), w, cardColor, textColor),
                  _recentChip(loc.getByKey('fashionStore'), w, cardColor, textColor),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔵 RECENT SEARCH CHIP (Theme aware)
  Widget _recentChip(
      String label,
      double w,
      Color bgColor,
      Color textColor,
      ) {
    return Chip(
      label: Text(
        label,
        style: TextStyle(
          fontSize: w * 0.035,
          color: textColor,
        ),
      ),
      backgroundColor: bgColor,
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
