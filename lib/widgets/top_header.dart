import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../User/provider/cart_provider.dart';
import '../User/screen/cart/cart_page.dart';
import '../User/screen/notification_screen.dart';
import '../User/screen/profile_screen.dart';
import '../User/screen/search_screen.dart';
import '../colors/AppColors.dart';

class TopHeader extends StatelessWidget {
  final bool hideProfileIcon;

  const TopHeader({
    super.key,
    this.hideProfileIcon = false, // default = show
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final width = mq.width;
    final height = mq.height;

    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(width * 0.05),
        bottomRight: Radius.circular(width * 0.05),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.012,
        ),
        decoration: const BoxDecoration(
          color: AppColors.primary,
        ),
        child: SafeArea(
          bottom: false,
          child: Row(
            children: [
              /// LOGO
              Container(
                height: width * 0.12,
                width: width * 0.12,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(width * 0.03),
                ),
                child: Padding(
                  padding: EdgeInsets.all(width * 0.015),
                  child: Image.asset(
                    "assets/images/logo.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              const Spacer(),

              _iconButton(context, Icons.search, const SearchScreen(), width),
              SizedBox(width: width * 0.06),

              _iconButton(
                context,
                Icons.notifications,
                const NotificationScreen(),
                width,
              ),
              SizedBox(width: width * 0.06),

              /// 🛒 CART
              Consumer<CartProvider>(
                builder: (context, cart, child) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CartScreen(),
                        ),
                      );
                    },
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                          size: width * 0.065,
                        ),
                        if (cart.cartCount > 0)
                          Positioned(
                            right: -4,
                            top: -4,
                            child: Container(
                              padding: EdgeInsets.all(width * 0.01),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                cart.cartCount.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: width * 0.025,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),

              /// 👤 PROFILE (conditional)
              if (!hideProfileIcon) ...[
                SizedBox(width: width * 0.06),
                _iconButton(
                  context,
                  Icons.person,
                  const ProfileScreen(),
                  width,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _iconButton(
      BuildContext context,
      IconData icon,
      Widget page,
      double size,
      ) {
    return GestureDetector(
      onTap: () =>
          Navigator.push(context, MaterialPageRoute(builder: (_) => page)),
      child: Icon(icon, color: Colors.white, size: size * 0.065),
    );
  }
}
