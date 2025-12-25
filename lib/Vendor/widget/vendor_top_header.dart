import 'package:flutter/material.dart';

class VendorTopHeader extends StatelessWidget
    implements PreferredSizeWidget {
  final VoidCallback? onNotificationTap;
  final VoidCallback? onProfileTap;

  const VendorTopHeader({
    super.key,
    this.onNotificationTap,
    this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary; // 🔥 SAME AS BOTTOM NAV

    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: primary, // ✅ PRIMARY COLOR
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      automaticallyImplyLeading: false,

      title: Image.asset(
        'assets/images/logo.png',
        height: 32,

      ),

      actions: [
        IconButton(
          icon: const Icon(
            Icons.notifications_none,
            color: Colors.white, // ✅ white icons
          ),
          onPressed: onNotificationTap,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
