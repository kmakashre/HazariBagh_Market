import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../colors/AppColors.dart';

class VendorDashboardScreen extends StatelessWidget {
  const VendorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(w * 0.04),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            child: Container(
              width: double.infinity,

              /// 🔽 HEIGHT REDUCED HERE
              padding: EdgeInsets.symmetric(
                horizontal: w * 0.05,
                vertical: w * 0.04,
              ),

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primaryDark,
                    AppColors.primary,
                    AppColors.primaryLight,
                  ],
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min, // 🔥 IMPORTANT
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome Vendor 👋",
                    style: GoogleFonts.inter(
                      fontSize: 22, // 🔽 smaller
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4), // 🔽 less space
                  Text(
                    "Manage your store and orders",
                    style: GoogleFonts.inter(
                      fontSize: 13, // 🔽 smaller
                      fontWeight: FontWeight.w500,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
