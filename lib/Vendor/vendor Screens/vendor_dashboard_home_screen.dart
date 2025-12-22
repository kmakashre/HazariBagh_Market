import 'package:flutter/material.dart';
import '../../widgets/top_header.dart';
import '../widget/vendor_bottom_Nav.dart';
import 'vendor_dashboard_screen.dart';
import 'vendor_orders_screen.dart';
import 'vendor_products_screen.dart';
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

  final List<Widget> screens = const [
    VendorDashboardScreen(),
    VendorProductsScreen(),
    VendorOrdersScreen(),
    VendorProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      body: Column(
        children: [
          const TopHeader(),
          Expanded(child: screens[currentIndex]),
        ],
      ),

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
