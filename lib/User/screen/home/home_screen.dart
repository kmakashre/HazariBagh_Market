import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../Model/home_model.dart';
import '../../../Model/store_model.dart';
import '../../../all_categories_screen.dart';
import '../../../colors/AppColors.dart';
import '../../../l10n/app_localizations.dart';
import '../../../widgets/top_header.dart';
import '../../provider/home_provider.dart';
import '../../provider/store_provider.dart';
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
  Timer? timer;

  final List<String> sliderImages = [
    "assets/images/clothe.jpg",
    "assets/images/grocery.jpg",
    "assets/images/electronics.jpg",
  ];

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
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    final bgColor = isDark ? AppColors.bgDark : AppColors.bgLight;
    final cardColor = isDark ? const Color(0xFF2A2A2A) : AppColors.white;
    final textColor = isDark ? AppColors.white : AppColors.textDark;

    final shadow = [
      BoxShadow(
        color: isDark ? Colors.black54 : AppColors.shadow,
        blurRadius: 12,
        offset: const Offset(0, 6),
      ),
    ];

    return Scaffold(
      backgroundColor: bgColor,
      body: FadeTransition(
        opacity: _fadeController,
        child: Column(
          children: [
            const TopHeader(),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(w * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// 🔵 WELCOME CARD (FULL WIDTH)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: w * 0.06,
                        vertical: h * 0.03,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(w * 0.05),
                        gradient: const LinearGradient(
                          colors: [
                            AppColors.primaryDark,
                            AppColors.primary,
                            AppColors.primaryLight,
                          ],
                        ),
                        boxShadow: shadow,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            loc.welcomeUser,
                            style: GoogleFonts.inter(
                              fontSize: w * 0.065,
                              fontWeight: FontWeight.w700,
                              color: AppColors.white,
                            ),
                          ),
                          SizedBox(height: h * 0.01),
                          Text(
                            loc.discoverStores,
                            style: GoogleFonts.inter(
                              fontSize: w * 0.035,
                              color: AppColors.white.withOpacity(0.85),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: h * 0.03),

                    /// 🖼 SLIDER
                    GestureDetector(
                      onTap: () => _openPage(const AllStoreScreen()),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(w * 0.045),
                          boxShadow: shadow,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(w * 0.045),
                          child: SizedBox(
                            height: h * 0.26,
                            child: Stack(
                              children: [

                                /// 🖼️ IMAGE SLIDER
                                PageView.builder(
                                  controller: _pageController,
                                  itemCount: sliderImages.length,
                                  itemBuilder: (_, index) {
                                    return Image.asset(
                                      sliderImages[index],
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    );
                                  },
                                ),

                                /// 🌑 DARK GRADIENT OVERLAY (Text visible rahe)
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        Colors.black.withOpacity(0.55),
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                ),

                                /// 🏷️ OFFER BADGE
                                Positioned(
                                  top: h * 0.02,
                                  left: w * 0.04,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: w * 0.035,
                                      vertical: h * 0.006,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.warning,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Text(
                                      "50% OFF",
                                      style: GoogleFonts.inter(
                                        fontSize: w * 0.035,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),

                                /// 📝 TEXT CONTENT
                                Positioned(
                                  left: w * 0.05,
                                  bottom: h * 0.025,
                                  right: w * 0.05,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context).bigSale,
                                        style: GoogleFonts.inter(
                                          fontSize: w * 0.065,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: h * 0.005),
                                      Text(
                                        AppLocalizations.of(context).groceryOffer,
                                        style: GoogleFonts.inter(
                                          fontSize: w * 0.035,
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
                    ),


                    SizedBox(height: h * 0.035),

                    /// 🟦 CATEGORIES
                    _sectionHeader(
                      title: loc.categories,
                      onViewAll: () =>
                          _openPage(const AllCategoriesScreen()),
                      textColor: textColor,
                    ),

                    SizedBox(height: h * 0.02),

                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                      homeCategories.length > 8 ? 8 : homeCategories.length,
                      gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: w * 0.04,
                        crossAxisSpacing: w * 0.04,
                        childAspectRatio: 0.75,
                      ),
                      itemBuilder: (_, index) {
                        final item = homeCategories[index];
                        return InkWell(
                          onTap: () => _openPage(item.screen),
                          borderRadius: BorderRadius.circular(w * 0.04),
                          child: Container(
                            padding: EdgeInsets.all(w * 0.025),
                            decoration: BoxDecoration(
                              color: cardColor,
                              borderRadius:
                              BorderRadius.circular(w * 0.04),
                              boxShadow: shadow,
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Image.asset(item.image),
                                ),
                                SizedBox(height: h * 0.008),
                                Text(
                                  loc.getByKey(item.titleKey),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.inter(
                                    fontSize: w * 0.03,
                                    fontWeight: FontWeight.w600,
                                    color: textColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                    SizedBox(height: h * 0.04),

                    /// 🏬 NEARBY STORES
                    _sectionHeader(
                      title: loc.nearbyStores,
                      onViewAll: () =>
                          _openPage(const AllStoreScreen()),
                      textColor: textColor,
                    ),

                    SizedBox(height: h * 0.02),

                    SizedBox(
                      height: h * 0.24,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: nearbyStores.length,
                        itemBuilder: (_, index) {
                          final store = nearbyStores[index];
                          return GestureDetector(
                            onTap: () {
                              context
                                  .read<StoreProvider>()
                                  .setStore(store);
                              _openPage(const StoreDetailsScreen());
                            },
                            child: Container(
                              width: w * 0.45,
                              margin:
                              EdgeInsets.only(right: w * 0.035),
                              decoration: BoxDecoration(
                                color: cardColor,
                                borderRadius:
                                BorderRadius.circular(w * 0.045),
                                boxShadow: shadow,
                              ),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius:
                                    BorderRadius.vertical(
                                      top: Radius.circular(w * 0.045),
                                    ),
                                    child: Image.asset(
                                      store.image,
                                      height: h * 0.14,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(w * 0.03),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          loc.getByKey(store.nameKey),
                                          maxLines: 1,
                                          overflow:
                                          TextOverflow.ellipsis,
                                          style: GoogleFonts.inter(
                                            fontWeight:
                                            FontWeight.w700,
                                            fontSize: w * 0.038,
                                            color: textColor,
                                          ),
                                        ),
                                        SizedBox(height: h * 0.004),
                                        Text(
                                          loc.getByKey(
                                              store.categoryKey),
                                          style: GoogleFonts.inter(
                                            fontSize: w * 0.028,
                                            color: AppColors.textGrey,
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

                    SizedBox(height: h * 0.02),

                    /// 🟧 BOTTOM SPECIAL OFFER
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: w * 0.07,
                        vertical: h * 0.035,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(w * 0.05),
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.warning,
                            Color(0xFFFFB300),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 14,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            loc.specialWeekend,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: w * 0.065,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: h * 0.01),
                          Text(
                            loc.flatOff,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: w * 0.038,
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
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader({
    required String title,
    required VoidCallback onViewAll,
    required Color textColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
        GestureDetector(
          onTap: onViewAll,
          child: Text(
            AppLocalizations.of(context)!.viewAll,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
