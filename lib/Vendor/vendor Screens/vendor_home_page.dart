import 'package:flutter/material.dart';
import 'package:hazari_bagh_market/Vendor/vendor%20Screens/vendor_add_product_screen.dart';
import 'package:hazari_bagh_market/Vendor/vendor%20Screens/vendor_orders_screen.dart';
import 'package:hazari_bagh_market/Vendor/vendor%20Screens/vendor_profile_screen.dart';
import 'package:hazari_bagh_market/Vendor/vendor%20Screens/vendor_reports_screen.dart';
import 'package:provider/provider.dart';

import '../VendorProvider/vendor_bottom_nav_provider.dart';
import '../widget/vendor_bottom_Nav.dart';
import 'Home/vendor_dashboard_screen.dart';


class VendorHomePage extends StatelessWidget {
  const VendorHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = context.watch<VendorBottomNavProvider>();

    final pages = const [
      VendorDashboardScreen(),
      VendorOrdersScreen(),
      VendorAddProductScreen(),
      VendorReportsScreen(),
      VendorProfileScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: nav.currentIndex,
        children: pages,
      ),
      bottomNavigationBar: VendorBottomNavBar(
        currentIndex: nav.currentIndex,
        onTabTapped: (index) {
          context
              .read<VendorBottomNavProvider>()
              .changeIndex(index); // ✅ NOW WORKS
        },
      ),
    );
  }
}
