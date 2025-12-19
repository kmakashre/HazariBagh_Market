import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hazari_bagh_market/screen/Auth/login_screen.dart';
import '../../widgets/top_header.dart';
import '../../provider/theme_provider.dart';
import '../../provider/language_provider.dart';
import '../../l10n/app_localizations.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    final t = AppLocalizations.of(context)!;
    final themeProvider = context.watch<ThemeProvider>();

    return Scaffold(
      body: Column(
        children: [
          const TopHeader(),

          /// 🔙 BACK
          Padding(
            padding: EdgeInsets.only(
              left: w * 0.04,
              top: h * 0.015,
              bottom: h * 0.01,
            ),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Row(
                children: [
                  Icon(Icons.arrow_back, size: w * 0.055),
                  SizedBox(width: w * 0.015),
                  Text(
                    t.back,
                    style: TextStyle(
                      fontSize: w * 0.04,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: w * 0.05,
                vertical: h * 0.025,
              ),
              child: Column(
                children: [
                  /// 👤 PROFILE IMAGE
                  CircleAvatar(
                    radius: w * 0.12,
                    backgroundImage:
                    const AssetImage("assets/images/girl.png"),
                  ),

                  SizedBox(height: h * 0.015),

                  /// 👤 NAME
                  Text(
                    "Jonathan Patterson",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: w * 0.05,
                    ),
                  ),

                  SizedBox(height: h * 0.005),

                  /// ✉ EMAIL
                  Text(
                    "hello@reallygreatsite.com",
                    style: TextStyle(
                      fontSize: w * 0.035,
                      color: Colors.black54,
                    ),
                  ),

                  SizedBox(height: h * 0.035),

                  /// ✏ EDIT PROFILE
                  profileTile(
                    w: w,
                    icon: Icons.edit,
                    title: t.editProfile,
                    iconColor: Colors.green,
                    onTap: () {},
                  ),

                  SizedBox(height: h * 0.03),

                  /// ⚙ GENERAL SETTINGS
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      t.generalSettings,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: w * 0.045,
                      ),
                    ),
                  ),

                  SizedBox(height: h * 0.015),

                  /// 🌗 DARK / LIGHT MODE
                  Container(
                    padding: EdgeInsets.symmetric(vertical: h * 0.015),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: w * 0.04,
                          backgroundColor: Colors.black,
                          child: Icon(
                            Icons.dark_mode,
                            color: Colors.white,
                            size: w * 0.04,
                          ),
                        ),
                        SizedBox(width: w * 0.03),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              t.mode,
                              style: TextStyle(fontSize: w * 0.038),
                            ),
                            Text(
                              t.darkLight,
                              style: TextStyle(
                                fontSize: w * 0.03,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Switch(
                          value:
                          themeProvider.themeMode == ThemeMode.dark,
                          onChanged: (value) {
                            themeProvider.toggleTheme(value);
                          },
                        ),
                      ],
                    ),
                  ),

                  /// 🌍 LANGUAGE
                  profileTile(
                    w: w,
                    icon: Icons.language,
                    title: t.language,
                    iconColor: Colors.amber,
                    onTap: () => _showLanguageDialog(context),
                  ),

                  profileTile(
                    w: w,
                    icon: Icons.settings,
                    title: t.settings,
                    iconColor: Colors.grey,
                    onTap: () {},
                  ),

                  profileTile(
                    w: w,
                    icon: Icons.info_outline,
                    title: t.about,
                    iconColor: Colors.purple,
                    onTap: () {},
                  ),

                  profileTile(
                    w: w,
                    icon: Icons.description,
                    title: t.terms,
                    iconColor: Colors.blue,
                    onTap: () {},
                  ),

                  profileTile(
                    w: w,
                    icon: Icons.privacy_tip,
                    title: t.privacy,
                    iconColor: Colors.red,
                    onTap: () {},
                  ),

                  SizedBox(height: h * 0.03),

                  /// 🚪 LOGOUT
                  InkWell(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const LoginScreen()),
                            (route) => false,
                      );
                    },
                    child: Container(
                      width: w * 0.8,
                      padding:
                      EdgeInsets.symmetric(vertical: h * 0.015),
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(w * 0.08),
                        color: Colors.grey.shade200,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.logout,
                              color: Colors.red, size: w * 0.05),
                          SizedBox(width: w * 0.02),
                          Text(
                            t.logout,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: w * 0.04,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🌍 LANGUAGE DIALOG
  void _showLanguageDialog(BuildContext context) {
    final langProvider = context.read<LanguageProvider>();
    final t = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(t.selectLanguage),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text("English"),
              onTap: () {
                langProvider.changeLanguage(const Locale('en'));
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("हिन्दी"),
              onTap: () {
                langProvider.changeLanguage(const Locale('hi'));
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  /// ♻ REUSABLE TILE
  Widget profileTile({
    required double w,
    required IconData icon,
    required String title,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: w * 0.04,
        backgroundColor: iconColor.withOpacity(0.2),
        child: Icon(icon, color: iconColor, size: w * 0.04),
      ),
      title: Text(title, style: TextStyle(fontSize: w * 0.038)),
      trailing: Icon(Icons.chevron_right, size: w * 0.05),
      onTap: onTap,
    );
  }
}
