import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screen/categories/categories_page.dart';
import '../screen/home/home_screen.dart';
import '../screen/orders/orders_page.dart';
import '../screen/support/support_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  final PageStorageBucket _bucket = PageStorageBucket();

  final List<Widget> pages = const [
    HomeScreen(),
    CategoryScreen(),
    MyOrdersScreen(),
    SupportPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final w = media.size.width;
    final h = media.size.height;
    final bottomPadding = media.padding.bottom;

    /// 🔹 RESPONSIVE SIZES
    final navHeight = h * 0.085 + bottomPadding;
    final iconSize = w * 0.065;
    final textSize = w * 0.030;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      /// ✅ BODY (STATE PRESERVED)
      body: SafeArea(
        bottom: false,
        child: PageStorage(
          bucket: _bucket,
          child: IndexedStack(
            index: currentIndex,
            children: pages,
          ),
        ),
      ),

      /// ✅ BOTTOM NAV BAR
      bottomNavigationBar: Container(
        height: navHeight,
        padding: EdgeInsets.only(bottom: bottomPadding),
        decoration: BoxDecoration(
          color: const Color(0xFF3670A3),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(w * 0.05),
            topRight: Radius.circular(w * 0.05),
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(Icons.home, "Home", 0, iconSize, textSize),
            _navItem(Icons.list_alt, "Categories", 1, iconSize, textSize),
            _navItem(Icons.inventory_2, "Orders", 2, iconSize, textSize),
            _navItem(Icons.headset_mic, "Support", 3, iconSize, textSize),
          ],
        ),
      ),
    );
  }

  /// 🔹 NAV ITEM (GOOGLE FONT)
  Widget _navItem(
      IconData icon,
      String label,
      int index,
      double iconSize,
      double textSize,
      ) {
    final isSelected = currentIndex == index;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (currentIndex != index) {
          setState(() => currentIndex = index);
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedScale(
            scale: isSelected ? 1.15 : 1.0,
            duration: const Duration(milliseconds: 200),
            child: Icon(
              icon,
              size: iconSize,
              color: isSelected ? Colors.white : Colors.white70,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: textSize,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
