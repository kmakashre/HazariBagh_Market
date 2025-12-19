import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
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

  final List<Widget> pages = const [
    HomeScreen(),
    CategoryScreen(),
    MyOrdersScreen(),
    SupportPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
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

      /// ✅ SAFE BODY (NOTCH SAFE)
      body: SafeArea(
        bottom: false,
        child: IndexedStack(
          index: currentIndex,
          children: pages,
        ),
      ),

      /// ✅ RESPONSIVE BOTTOM NAV
      bottomNavigationBar: Container(
        height: navHeight,
        padding: EdgeInsets.only(bottom: bottomPadding),
        decoration: BoxDecoration(
          color: const Color(0xFF3670A3),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(w * 0.05),
            topRight: Radius.circular(w * 0.05),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(Icons.home, loc.navHome, 0, iconSize, textSize),
            _navItem(Icons.list_alt, loc.navCategories, 1, iconSize, textSize),
            _navItem(Icons.inventory_2, loc.navOrders, 2, iconSize, textSize),
            _navItem(Icons.headset_mic, loc.navSupport, 3, iconSize, textSize),
          ],
        ),
      ),
    );
  }

  /// 🔹 NAV ITEM (RESPONSIVE)
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
      onTap: () => setState(() => currentIndex = index),
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
            style: TextStyle(
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
