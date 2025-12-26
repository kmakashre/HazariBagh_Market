import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../colors/AppColors.dart';
import '../../widgets/top_header.dart';
import '../provider/theme_provider.dart';
import 'All Categories/job/job_details_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final themeProvider = context.watch<ThemeProvider>();

    final bgColor = isDark ? AppColors.bgDark : AppColors.white;
    final cardColor =
    isDark ? const Color(0xFF1E1E1E) : AppColors.white;
    final textColor = theme.textTheme.bodyLarge!.color!;
    final subTextColor =
    isDark ? Colors.grey.shade400 : Colors.grey;

    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        children: [
          /// 🔝 TOP HEADER
          const TopHeader(hideProfileIcon: true),

          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: w * 0.04,
              vertical: 10,
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () => Navigator.pop(context),
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.black,
                    size: w * 0.06,
                  ),
                  SizedBox(width: w * 0.02),
                  Text(
                    "Back",
                    style: GoogleFonts.poppins(
                      fontSize: w * 0.045,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// 📄 CONTENT
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: w * 0.06),
              child: Column(
                children: [
                  SizedBox(height: h * 0.03),

                  /// 👤 PROFILE IMAGE
                  CircleAvatar(
                    radius: w * 0.14,
                    backgroundColor: isDark
                        ? Colors.grey.shade700
                        : Colors.grey.shade300,
                    child: CircleAvatar(
                      radius: w * 0.135,
                      backgroundImage:
                      const AssetImage("assets/images/girl.jpg"),
                    ),
                  ),

                  SizedBox(height: h * 0.015),

                  /// 👤 NAME
                  Text(
                    "Jonathan Patterson",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: textColor,
                    ),
                  ),

                  const SizedBox(height: 4),

                  /// 📧 EMAIL
                  Text(
                    "hello@reallygreatsite.com",
                    style: TextStyle(
                      fontSize: 14,
                      color: subTextColor,
                    ),
                  ),

                  SizedBox(height: h * 0.03),

                  /// ✏ EDIT PROFILE
                  _menuTile(
                    context: context,
                    icon: Icons.edit,
                    iconColor: Colors.green,
                    title: "Edit Profile",
                    tileColor: cardColor,
                    onTap: () {},
                  ),

                  SizedBox(height: h * 0.025),

                  /// ⚙ GENERAL SETTINGS
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "General Settings",
                      style: TextStyle(
                        fontSize: w * 0.045,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                  ),

                  SizedBox(height: h * 0.015),

                  /// 🌗 DARK MODE
                  _menuTile(
                    context: context,
                    icon: Icons.dark_mode,
                    iconColor:
                    isDark ? Colors.amber : Colors.black,
                    title: "Dark Mode",
                    tileColor: cardColor,
                    trailing: Switch.adaptive(
                      activeColor: AppColors.primary,
                      value: themeProvider.isDarkMode,
                      onChanged: themeProvider.toggleTheme,
                    ),
                  ),

                  _menuTile(
                    context: context,
                    icon: Icons.language,
                    iconColor: Colors.orange,
                    title: "Language",
                    tileColor: cardColor,
                  ),

                  _menuTile(
                    context: context,
                    icon: Icons.settings,
                    iconColor: Colors.grey,
                    title: "Settings",
                    tileColor: cardColor,
                  ),

                  _menuTile(
                    context: context,
                    icon: Icons.info_outline,
                    iconColor: Colors.purple,
                    title: "About",
                    tileColor: cardColor,
                  ),

                  _menuTile(
                    context: context,
                    icon: Icons.description,
                    iconColor: Colors.blue,
                    title: "Terms & Conditions",
                    tileColor: cardColor,
                  ),

                  _menuTile(
                    context: context,
                    icon: Icons.privacy_tip_outlined,
                    iconColor: Colors.redAccent,
                    title: "Privacy Policy",
                    tileColor: cardColor,
                  ),

                  _menuTile(
                    context: context,
                    icon: Icons.star_rate,
                    iconColor: Colors.amber,
                    title: "Rate This App",
                    tileColor: cardColor,
                  ),

                  _menuTile(
                    context: context,
                    icon: Icons.share,
                    iconColor: Colors.pink,
                    title: "Share This App",
                    tileColor: cardColor,
                  ),

                  SizedBox(height: h * 0.04),

                  /// 🚪 LOGOUT
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isDark
                            ? Colors.grey.shade800
                            : Colors.grey.shade200,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      icon:
                      const Icon(Icons.logout, color: Colors.red),
                      label: const Text(
                        "Logout",
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () {},
                    ),
                  ),

                  SizedBox(height: h * 0.03),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ♻ MENU TILE
  static Widget _menuTile({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String title,
    required Color tileColor,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    final textColor = Theme.of(context).textTheme.bodyLarge!.color;

    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        color: tileColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: iconColor.withOpacity(0.15),
          child: Icon(icon, color: iconColor),
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: 15, color: textColor),
        ),
        trailing: trailing ??
            const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}
