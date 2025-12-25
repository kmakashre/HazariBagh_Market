import 'package:flutter/material.dart';

class VendorBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabTapped;

  const VendorBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTabTapped,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final bgColor =
    isDark ? const Color(0xFF0F172A) : Colors.white;
    final primary = theme.colorScheme.primary;
    final inactiveColor =
    isDark ? Colors.grey.shade400 : Colors.grey;

    return Container(
      // 🔥 IMPORTANT: fill bottom area
      color: bgColor,
      child: SafeArea(
        top: false, // ❌ top safe area not needed
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(22),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: bgColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 12,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _navItem(
                  icon: Icons.home,
                  label: "Home",
                  index: 0,
                  primary: primary,
                  inactive: inactiveColor,
                ),
                _navItem(
                  icon: Icons.shopping_cart,
                  label: "Orders",
                  index: 1,
                  primary: primary,
                  inactive: inactiveColor,
                ),

                /// ➕ CENTER ADD BUTTON
                _addButton(primary),

                _navItem(
                  icon: Icons.bar_chart,
                  label: "Reports",
                  index: 3,
                  primary: primary,
                  inactive: inactiveColor,
                ),
                _navItem(
                  icon: Icons.person,
                  label: "Profile",
                  index: 4,
                  primary: primary,
                  inactive: inactiveColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 🔹 NORMAL NAV ITEM
  Widget _navItem({
    required IconData icon,
    required String label,
    required int index,
    required Color primary,
    required Color inactive,
  }) {
    final bool isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () => onTabTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 26,
            color: isSelected ? primary : inactive,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isSelected ? primary : inactive,
            ),
          ),
        ],
      ),
    );
  }

  /// ➕ CENTER ADD BUTTON
  Widget _addButton(Color primary) {
    return GestureDetector(
      onTap: () => onTabTapped(2),
      child: Container(
        height: 56,
        width: 56,
        decoration: BoxDecoration(
          color: primary,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: primary.withOpacity(0.4),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Icon(
          Icons.add,
          size: 32,
          color: Colors.white,
        ),
      ),
    );
  }
}
