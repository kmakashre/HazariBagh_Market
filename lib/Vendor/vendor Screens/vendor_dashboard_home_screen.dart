import 'package:flutter/material.dart';
import 'package:hazari_bagh_market/Vendor/vendor%20Screens/vendor_add_product_screen.dart';
import 'package:hazari_bagh_market/Vendor/vendor%20Screens/vendor_reports_screen.dart';
import '../../widgets/top_header.dart';
import '../widget/vendor_bottom_Nav.dart';
import '../widget/vendor_top_header.dart';
import 'Home/vendor_dashboard_screen.dart';
import 'vendor_orders_screen.dart';
import 'vendor_profile_screen.dart';

class VendorDashboardHomeScreen extends StatefulWidget {
  const VendorDashboardHomeScreen({super.key});

  @override
  State<VendorDashboardHomeScreen> createState() =>
      _VendorDashboardHomeScreenState();
}

class _VendorDashboardHomeScreenState
    extends State<VendorDashboardHomeScreen> {

  int currentIndex = 0;

  late final List<Widget> screens;

  @override
  void initState() {
    super.initState();

    screens = const [
      VendorDashboardScreen(),     // 🏠 Home
      VendorOrdersScreen(),        // 📦 Orders
      VendorAddProductScreen(),    // ➕ Add
      VendorReportsScreen(),       // 📊 Reports
      VendorProfileScreen(),       // 👤 Profile
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      body: Column(
        children: [
          /// 🔝 COMMON HEADER
          const VendorTopHeader(),

          /// 📱 SCREEN CONTENT
          Expanded(
            child: screens[currentIndex],
          ),
        ],
      ),

      /// 🔽 BOTTOM NAV
      bottomNavigationBar: VendorBottomNavBar(
        currentIndex: currentIndex,
        onTabTapped: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
