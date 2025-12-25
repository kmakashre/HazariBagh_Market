import 'package:flutter/material.dart';
import 'package:hazari_bagh_market/widgets/user_bottom_nav.dart';
import 'package:provider/provider.dart';
import '../User/provider/bottom_nav_provider.dart';
import '../User/screen/categories/categories_page.dart';
import '../User/screen/home/home_screen.dart';
import '../User/screen/orders/orders_page.dart';
import '../User/screen/support/support_page.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = context.watch<BottomNavProvider>();

    final pages = const [
      HomeScreen(),
      CategoryScreen(),
      MyOrdersScreen(),
      SupportPage(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: nav.currentIndex,
        children: pages,
      ),
      bottomNavigationBar: const UserBottomNav(),
    );
  }
}
