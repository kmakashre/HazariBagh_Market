import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../User/provider/theme_provider.dart';
import '../VendorProvider/vendor_profile_provider.dart';

class VendorProfileScreen extends StatelessWidget {
  const VendorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    final theme = Theme.of(context);
    final themeProvider = context.watch<ThemeProvider>();
    final profile = context.watch<VendorProfileProvider>();

    final isDark = themeProvider.isDarkMode;
    final primary = theme.colorScheme.primary;

    final bgColor =
    isDark ? const Color(0xFF121212) : const Color(0xFFF5F7FA);

    final tileColor =
    isDark ? const Color(0xFF1E1E1E) : Colors.white;

    final shadowColor =
    isDark ? Colors.black.withOpacity(0.4) : Colors.black.withOpacity(0.08);

    final textColor = isDark ? Colors.white : Colors.black87;

    return Scaffold(
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(w * 0.045),
        child: Column(
          children: [
            /// 👤 PROFILE HEADER
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: w * 0.05,
                vertical: h * 0.025,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    primary,
                    primary.withOpacity(0.85),
                  ],
                ),
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: shadowColor,
                    blurRadius: 10,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: w * 0.14,
                    // backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: w * 0.13,
                      backgroundImage: profile.profileImage != null
                          ? FileImage(profile.profileImage!)
                          : const AssetImage("assets/images/girl.jpg")
                      as ImageProvider,
                    ),
                  ),
                  SizedBox(height: h * 0.018),
                  Text(
                    profile.shopName,
                    style: TextStyle(
                      fontSize: w * 0.05,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: h * 0.006),
                  Text(
                    "📞 ${profile.phone}",
                    style: TextStyle(
                      fontSize: w * 0.035,
                      color: Colors.white.withOpacity(0.85),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: h * 0.04),

            _profileTile(
              context,
              icon: Icons.edit,
              title: "Edit Profile",
              onTap: () {
                /// Example update
                context.read<VendorProfileProvider>().updateProfile(
                  shop: "New Shop Name",
                  phoneNo: "9999999999",
                );
              },
              tileColor: tileColor,
              shadowColor: shadowColor,
              primary: primary,
              textColor: textColor,
              isDark: isDark,
            ),

            _profileTile(
              context,
              icon: Icons.store,
              title: "Business Details",
              onTap: () {},
              tileColor: tileColor,
              shadowColor: shadowColor,
              primary: primary,
              textColor: textColor,
              isDark: isDark,
            ),

            _profileTile(
              context,
              icon: Icons.lock_outline,
              title: "Change Password",
              onTap: () {},
              tileColor: tileColor,
              shadowColor: shadowColor,
              primary: primary,
              textColor: textColor,
              isDark: isDark,
            ),

            /// 🌗 DARK MODE
            Container(
              decoration: BoxDecoration(
                color: tileColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(color: shadowColor, blurRadius: 6),
                ],
              ),
              child: SwitchListTile(
                value: isDark,
                onChanged: themeProvider.toggleTheme,
                title: Text(
                  "Dark Mode",
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                secondary: Icon(
                  isDark ? Icons.dark_mode : Icons.light_mode,
                  color: primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileTile(
      BuildContext context, {
        required IconData icon,
        required String title,
        required VoidCallback onTap,
        required Color tileColor,
        required Color shadowColor,
        required Color primary,
        required Color textColor,
        required bool isDark,
      }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: tileColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
          primary.withOpacity(isDark ? 0.25 : 0.12),
          child: Icon(icon, color: primary),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing:
        Icon(Icons.chevron_right, color: textColor.withOpacity(0.5)),
        onTap: onTap,
      ),
    );
  }
}
