import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/top_header.dart';
import '../../l10n/app_localizations.dart';
import '../../colors/AppColors.dart';
import '../../services/auth_api_service.dart';
import '../../Model/user_model.dart';
import '../provider/theme_provider.dart';
import 'Auth/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<UserProfileResponse> _profileFuture;

  @override
  void initState() {
    super.initState();
    _profileFuture = _loadProfile();
  }

  Future<UserProfileResponse> _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    if (token == null || token.isEmpty) {
      throw Exception("Token not found");
    }

    return AuthApiService.getUserProfile(token);
  }

  Future<void> _deleteAccount(BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");

      if (token == null) return;

      await AuthApiService.deleteAccount(token);

      await prefs.clear();

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
            (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to delete account"),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final themeProvider = context.watch<ThemeProvider>();
    final isDark = theme.brightness == Brightness.dark;

    final bgColor = isDark ? AppColors.bgDark : AppColors.bgLight;
    final tileBgColor =
    isDark ? const Color(0xFF2A2A2A) : AppColors.white;
    final iconBgColor =
    isDark ? Colors.grey.shade800 : Colors.grey.shade200;

    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        children: [
          const TopHeader(),

          /// 🔙 BACK BUTTON
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
                  Icon(
                    Icons.arrow_back,
                    size: w * 0.055,
                    color: AppColors.primary,
                  ),
                  SizedBox(width: w * 0.015),
                  Text(
                    t.back,
                    style: TextStyle(
                      fontSize: w * 0.04,
                      fontWeight: FontWeight.w600,
                      color: theme.textTheme.bodyLarge!.color,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: FutureBuilder<UserProfileResponse>(
              future: _profileFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError || !snapshot.hasData) {
                  return Center(
                    child: Text(
                      "Failed to load profile",
                      style: TextStyle(
                        color: theme.textTheme.bodyLarge!.color,
                      ),
                    ),
                  );
                }

                final user = snapshot.data!.user;

                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: w * 0.05,
                    vertical: h * 0.025,
                  ),
                  child: Column(
                    children: [
                      /// 👤 PROFILE IMAGE
                      CircleAvatar(
                        radius: w * 0.12,
                        backgroundColor: iconBgColor,
                        child: CircleAvatar(
                          radius: w * 0.115,
                          backgroundImage:
                          const AssetImage("assets/images/girl.jpg"),
                        ),
                      ),

                      SizedBox(height: h * 0.015),

                      /// 👤 NAME
                      Text(
                        "User",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: w * 0.05,
                          color:
                          theme.textTheme.bodyLarge!.color,
                        ),
                      ),

                      SizedBox(height: h * 0.005),

                      /// 📞 PHONE
                      Text(
                        user.phone,
                        style: TextStyle(
                          fontSize: w * 0.035,
                          color:
                          theme.textTheme.bodySmall!.color,
                        ),
                      ),

                      SizedBox(height: h * 0.035),

                      _profileTile(
                        context: context,
                        w: w,
                        icon: Icons.edit,
                        title: t.editProfile,
                        iconColor: AppColors.success,
                        tileBgColor: tileBgColor,
                        onTap: () {},
                      ),

                      _profileTile(
                        context: context,
                        w: w,
                        icon: Icons.delete_forever,
                        title: "Delete Account",
                        iconColor: Colors.red,
                        tileBgColor: tileBgColor,
                        onTap: () => _confirmDeleteAccount(context),
                      ),

                      SizedBox(height: h * 0.03),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          t.generalSettings,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: w * 0.045,
                            color: theme
                                .textTheme.bodyLarge!.color,
                          ),
                        ),
                      ),

                      SizedBox(height: h * 0.015),

                      /// 🌗 THEME SWITCH
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: h * 0.015,
                          horizontal: w * 0.04,
                        ),
                        decoration: BoxDecoration(
                          color: tileBgColor,
                          borderRadius:
                          BorderRadius.circular(w * 0.03),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: w * 0.04,
                              backgroundColor:
                              AppColors.primary,
                              child: Icon(
                                isDark
                                    ? Icons.dark_mode
                                    : Icons.light_mode,
                                color: AppColors.white,
                              ),
                            ),
                            SizedBox(width: w * 0.03),
                            Text(
                              t.mode,
                              style: TextStyle(
                                fontSize: w * 0.038,
                                color: theme.textTheme
                                    .bodyLarge!.color,
                              ),
                            ),
                            const Spacer(),
                            Switch.adaptive(
                              activeColor:
                              AppColors.primary,
                              value: themeProvider
                                  .themeMode ==
                                  ThemeMode.dark,
                              onChanged:
                              themeProvider.toggleTheme,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: h * 0.03),

                      /// 🚪 LOGOUT
                      InkWell(
                        onTap: () async {
                          final prefs =
                          await SharedPreferences
                              .getInstance();
                          await prefs.clear();

                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                              const LoginScreen(),
                            ),
                                (route) => false,
                          );
                        },
                        child: Container(
                          width: w * 0.8,
                          padding: EdgeInsets.symmetric(
                              vertical: h * 0.015),
                          decoration: BoxDecoration(
                            color: tileBgColor,
                            borderRadius:
                            BorderRadius.circular(
                                w * 0.08),
                          ),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              Icon(Icons.logout,
                                  color: AppColors.error),
                              SizedBox(width: w * 0.02),
                              Text(
                                t.logout,
                                style: TextStyle(
                                  color: AppColors.error,
                                  fontSize: w * 0.04,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// ♻ REUSABLE TILE
  Widget _profileTile({
    required BuildContext context,
    required double w,
    required IconData icon,
    required String title,
    required Color iconColor,
    required Color tileBgColor,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.symmetric(vertical: w * 0.01),
      decoration: BoxDecoration(
        color: tileBgColor,
        borderRadius: BorderRadius.circular(w * 0.03),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: iconColor.withOpacity(0.2),
          child: Icon(icon, color: iconColor),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: theme.textTheme.bodyLarge!.color,
          ),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  void _confirmDeleteAccount(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Account"),
        content: const Text(
          "Are you sure? This action cannot be undone.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () async {
              Navigator.pop(context);
              await _deleteAccount(context);
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }

}
