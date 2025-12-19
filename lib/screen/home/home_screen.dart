import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../Model/home_model.dart';
import '../../Model/store_model.dart';
import '../../all_categories_screen.dart';
import '../../colors/AppColors.dart';
import '../../l10n/app_localizations.dart';
import '../../provider/store_provider.dart';
import '../../widgets/top_header.dart';
import '../../provider/home_provider.dart';
import '../all_store_screen.dart';
import '../store_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  late AnimationController _fadeController;

  final List<String> sliderImages = [
    "assets/images/clothe.jpg",
    "assets/images/grocery.jpg",
    "assets/images/electronics.jpg",
  ];

  Timer? timer;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();

    timer = Timer.periodic(const Duration(seconds: 3), (_) {
      final provider = context.read<HomeProvider>();
      int next = provider.bannerIndex + 1;
      if (next == sliderImages.length) next = 0;

      _pageController.animateToPage(
        next,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      provider.changeBanner(next);
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    _fadeController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _openPage(Widget page) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (_, a, __) => FadeTransition(
          opacity: a,
          child: SlideTransition(
            position:
            Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
                .animate(a),
            child: page,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context); // ✅ CORRECT
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final provider = context.watch<HomeProvider>();

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: FadeTransition(
        opacity: _fadeController,
        child: Column(
          children: [
            const TopHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(w * 0.03),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// 🔵 WELCOME CARD
                    Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(w * 0.06),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: const LinearGradient(
                            colors: [
                              AppColors.primaryDark,
                              AppColors.primary,
                              AppColors.primaryLight,
                            ],
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              loc.welcomeUser,
                              style: GoogleFonts.inter(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              loc.discoverStores,
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: h * 0.02),

                    /// 🖼️ SLIDER
                    GestureDetector(
                      onTap: () => _openPage(const AllStoreScreen()),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: SizedBox(
                          height: h * 0.24,
                          child: Stack(
                            children: [
                              PageView.builder(
                                controller: _pageController,
                                itemCount: sliderImages.length,
                                onPageChanged: provider.changeBanner,
                                itemBuilder: (_, index) {
                                  return Image.asset(
                                    sliderImages[index],
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  );
                                },
                              ),

                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.black.withOpacity(0.55),
                                      Colors.transparent,
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  ),
                                ),
                              ),

                              Positioned(
                                left: 16,
                                bottom: 16,
                                right: 16,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: Colors.yellow.shade700,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        "50% OFF",
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      loc.bigSale,
                                      style: GoogleFonts.inter(
                                        fontSize: 30,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      loc.groceryOffer,
                                      style: GoogleFonts.inter(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: h * 0.03),

                    /// 🟦 CATEGORIES
                    _sectionHeader(
                      title: loc.categories,
                      onViewAll: () =>
                          _openPage(const AllCategoriesScreen()),
                    ),

                    SizedBox(height: h * 0.01),

                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                      homeCategories.length > 8 ? 8 : homeCategories.length,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 0.74,
                      ),
                      itemBuilder: (_, index) {
                        final item = homeCategories[index];

                        return InkWell(
                          borderRadius: BorderRadius.circular(18),
                          onTap: () => _openPage(item.screen),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  blurRadius: 14,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 6,
                                  child: Image.asset(
                                    item.image,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Expanded(
                                  flex: 3,
                                  child: Center(
                                    child: Text(
                                      loc.getByKey(item.titleKey),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                    SizedBox(height: h * 0.03),

                    /// 🏬 NEARBY STORES
                    _sectionHeader(
                      title: loc.nearbyStores,
                      onViewAll: () =>
                          _openPage(const AllStoreScreen()),
                    ),

                    SizedBox(height: h * 0.01),

                    SizedBox(
                      height: 170,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: nearbyStores.length,
                        itemBuilder: (_, index) {
                          final store = nearbyStores[index];

                          return GestureDetector(
                            onTap: () {
                              /// ✅ SET STORE IN PROVIDER
                              context.read<StoreProvider>().setStore(store);

                              /// ✅ NAVIGATE TO DETAILS SCREEN
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const StoreDetailsScreen(),
                                ),
                              );
                            },
                            child: Container(
                              width: 170,
                              margin: const EdgeInsets.only(right: 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.08),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// 🖼 IMAGE
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(14),
                                    ),
                                    child: Image.asset(
                                      store.image,
                                      height: 110,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),

                                  /// 📄 TEXT
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          loc.getByKey(store.nameKey),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: w * 0.04,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Text(
                                          loc.getByKey(store.categoryKey),
                                          style: GoogleFonts.inter(
                                            fontSize: 11,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    SizedBox(height: h * 0.03),

                    /// 🟧 BOTTOM OFFER
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 28),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFFF9800),
                            Color(0xFFFFB300),
                          ],
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            loc.specialWeekend,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            loc.flatOff,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader({
    required String title,
    required VoidCallback onViewAll,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        GestureDetector(
          onTap: onViewAll,
          child: Text(
            AppLocalizations.of(context).viewAll,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
              color: const Color(0xFF3670A3),
            ),
          ),
        ),
      ],
    );
  }
}
