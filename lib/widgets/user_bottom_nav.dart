import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../User/provider/bottom_nav_provider.dart';
import '../l10n/app_localizations.dart';

class UserBottomNav extends StatelessWidget {
  const UserBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = context.watch<BottomNavProvider>();
    final loc = AppLocalizations.of(context)!;
    final w = MediaQuery.of(context).size.width;

    return Container(
      height: 70,
      decoration: const BoxDecoration(
        color: Color(0xFF3670A3),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _item(context, Icons.home, loc.navHome, 0),
          _item(context, Icons.list_alt, loc.navCategories, 1),
          _item(context, Icons.inventory_2, loc.navOrders, 2),
          _item(context, Icons.headset_mic, loc.navSupport, 3),
        ],
      ),
    );
  }

  Widget _item(
      BuildContext context, IconData icon, String label, int index) {
    final nav = context.watch<BottomNavProvider>();
    final isActive = nav.currentIndex == index;

    return GestureDetector(
      onTap: () => context.read<BottomNavProvider>().changeIndex(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: isActive ? Colors.white : Colors.white70),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
